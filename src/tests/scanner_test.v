import token
import source
import scanner

fn test_scanner_skip_whitespace() {
    src := source.new('    \t\n  + - * / , . ; : = ( ) [ ] { }')
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .plus,
        pos: source.Position{line: 2, column: 3},
        lexeme: '+'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .minus,
        pos: source.Position{line: 2, column: 5},
        lexeme: '-'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .times,
        pos: source.Position{line: 2, column: 7},
        lexeme: '*'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .slash,
        pos: source.Position{line: 2, column: 9},
        lexeme: '/'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .comma,
        pos: source.Position{line: 2, column: 11},
        lexeme: ','
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .period,
        pos: source.Position{line: 2, column: 13},
        lexeme: '.'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .semicolon,
        pos: source.Position{line: 2, column: 15},
        lexeme: ';'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .colon,
        pos: source.Position{line: 2, column: 17},
        lexeme: ':'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .eql,
        pos: source.Position{line: 2, column: 19},
        lexeme: '='
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .lparen,
        pos: source.Position{line: 2, column: 21},
        lexeme: '('
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .rparen,
        pos: source.Position{line: 2, column: 23},
        lexeme: ')'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .lbrak,
        pos: source.Position{line: 2, column: 25},
        lexeme: '['
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .rbrak,
        pos: source.Position{line: 2, column: 27},
        lexeme: ']'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .lbrace,
        pos: source.Position{line: 2, column: 29},
        lexeme: '{'
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .rbrace,
        pos: source.Position{line: 2, column: 31},
        lexeme: '}'
    }
}

fn test_scan_integer() {
	src := source.new('12345')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .int_literal,
		lexeme: '12345',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_octal() {
	src := source.new('1234B')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .int_literal,
		lexeme: '1234B',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_long_integer() {
	src := source.new('1234D')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .int_literal,
		lexeme: '1234D',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_hexadecimal() {
	src := source.new('1A2BH')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .int_literal,
		lexeme: '1A2BH',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_real_number() {
	src := source.new('123.456')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .real_literal,
		lexeme: '123.456',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_real_number_with_exponent() {
	src := source.new('123.456E+7')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .real_literal,
		lexeme: '123.456E+7',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_real_number_with_negative_exponent() {
	src := source.new('123.456E-7')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .real_literal,
		lexeme: '123.456E-7',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_ellipsis() {
	src := source.new('123..456')
	mut s := scanner.new(src)
	s.advance()
	mut expected_token := token.Token{
		kind: .int_literal,
		lexeme: '123',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
	s.advance()
	expected_token = token.Token{
		kind: .ellipsis,
		lexeme: '..',
		pos: source.Position{line: 1, column: 4},
	}
	assert s.current_token() == expected_token
}

fn test_scan_real_number_ending_with_dot() {
	src := source.new('123.')
	mut s := scanner.new(src)
	s.advance()
	expected_token := token.Token{
		kind: .real_literal,
		lexeme: '123.',
		pos: source.Position{line: 1, column: 1},
	}
	assert s.current_token() == expected_token
}

fn test_scan_identifier() {
    // Test identifiers
    src := source.new('identifier anotherIdentifier 123number IF ELSE THEN PROCEDURE')
    mut s := scanner.new(src)

    // Scan identifiers
    s.advance() // identifier
    expected1 := token.Token{
        kind: .ident,
        lexeme: 'identifier',
        pos: source.Position{line: 1, column: 1}
    }
    assert s.current_token() == expected1
    assert !s.current_token().kind.is_keyword()

    s.advance() // anotherIdentifier
    expected2 := token.Token{
        kind: .ident,
        lexeme: 'anotherIdentifier',
        pos: source.Position{line: 1, column: 12} // Adjust column number based on spacing
    }
    assert s.current_token() == expected2
    assert !s.current_token().kind.is_keyword()

    s.advance() // 123number (treated as int_literal number in this case)
    expected3 := token.Token{
        kind: .int_literal,
        lexeme: '123',
        pos: source.Position{line: 1, column: 30} // Adjust column number based on spacing
    }
    assert s.current_token() == expected3
    assert !s.current_token().kind.is_keyword()
    assert s.current_token().kind.is_literal()

    s.advance() // number (treated as identifier in this case)
    expected4 := token.Token{
        kind: .ident,
        lexeme: 'number',
        pos: source.Position{line: 1, column: 33} // Adjust column number based on spacing
    }
    assert s.current_token() == expected4
    assert !s.current_token().kind.is_keyword()

    s.advance() // IF(treated as keyword in this case)
    expected5 := token.Token{
        kind: .@if,
        lexeme: 'IF',
        pos: source.Position{line: 1, column: 40} // Adjust column number based on spacing
    }
    assert s.current_token() == expected5
    assert s.current_token().kind.is_keyword()

    s.advance() // ELSE (treated as keyword in this case)
    expected6 := token.Token{
        kind: .@else,
        lexeme: 'ELSE',
        pos: source.Position{line: 1, column: 43} // Adjust column number based on spacing
    }
    assert s.current_token() == expected6
    assert s.current_token().kind.is_keyword()

    s.advance() // THEN (treated as keyword in this case)
    expected7 := token.Token{
        kind: .then,
        lexeme: 'THEN',
        pos: source.Position{line: 1, column: 48} // Adjust column number based on spacing
    }
    assert s.current_token() == expected7
    assert s.current_token().kind.is_keyword()

    s.advance() // PROCEDURE (treated as keyword in this case)
    expected8 := token.Token{
        kind: .procedure,
        lexeme: 'PROCEDURE',
        pos: source.Position{line: 1, column: 53} // Adjust column number based on spacing
    }
    assert s.current_token() == expected8
    assert s.current_token().kind.is_keyword()
}

fn test_scan_illegal_tokens() {
    // Test string with a mix of valid and illegal characters
    src := source.new('valid _ identifier $ invalid!character % another?identifier @ identifier\\with`backtick')
    mut s := scanner.new(src)

    // Scan valid identifier
    s.advance() // valid
    expected1 := token.Token{
        kind: .ident,
        lexeme: 'valid',
        pos: source.Position{line: 1, column: 1}
    }
    assert s.current_token() == expected1

    // Scan illegal character _
    s.advance() // _
    expected2 := token.Token{
        kind: .null,
        lexeme: '_',
        pos: source.Position{line: 1, column: 7} // Adjust column number based on spacing
    }
    assert s.current_token() == expected2

    // Scan valid identifier
    s.advance() // identifier
    expected3 := token.Token{
        kind: .ident,
        lexeme: 'identifier',
        pos: source.Position{line: 1, column: 9} // Adjust column number based on spacing
    }
    assert s.current_token() == expected3

    // Scan illegal character $
    s.advance() // $
    expected4 := token.Token{
        kind: .null,
        lexeme: '$',
        pos: source.Position{line: 1, column: 20} // Adjust column number based on spacing
    }
    assert s.current_token() == expected4

    // Scan invalid identifier up to the next illegal character
    s.advance() // invalid
    expected5 := token.Token{
        kind: .ident,
        lexeme: 'invalid',
        pos: source.Position{line: 1, column: 22} // Adjust column number based on spacing
    }
    assert s.current_token() == expected5

    // Scan illegal character !
    s.advance() // !
    expected6 := token.Token{
        kind: .null,
        lexeme: '!',
        pos: source.Position{line: 1, column: 29} // Adjust column number based on spacing
    }
    assert s.current_token() == expected6

    // Scan valid identifier
    s.advance() // character
    expected7 := token.Token{
        kind: .ident,
        lexeme: 'character',
        pos: source.Position{line: 1, column: 30} // Adjust column number based on spacing
    }
    assert s.current_token() == expected7

    // Scan illegal character %
    s.advance() // %
    expected8 := token.Token{
        kind: .null,
        lexeme: '%',
        pos: source.Position{line: 1, column: 40} // Adjust column number based on spacing
    }
    assert s.current_token() == expected8

    // Scan valid identifier
    s.advance() // another
    expected9 := token.Token{
        kind: .ident,
        lexeme: 'another',
        pos: source.Position{line: 1, column: 42} // Adjust column number based on spacing
    }
    assert s.current_token() == expected9

    // Scan illegal character ?
    s.advance() // ?
    expected10 := token.Token{
        kind: .null,
        lexeme: '?',
        pos: source.Position{line: 1, column: 49} // Adjust column number based on spacing
    }
    assert s.current_token() == expected10

    // Scan valid identifier
    s.advance() // identifier
    expected11 := token.Token{
        kind: .ident,
        lexeme: 'identifier',
        pos: source.Position{line: 1, column: 50} // Adjust column number based on spacing
    }
    assert s.current_token() == expected11

    // Scan illegal character @
    s.advance() // @
    expected12 := token.Token{
        kind: .null,
        lexeme: '@',
        pos: source.Position{line: 1, column: 61} // Adjust column number based on spacing
    }
    assert s.current_token() == expected12

    // Scan valid identifier
    s.advance() // identifier
    expected13 := token.Token{
        kind: .ident,
        lexeme: 'identifier',
        pos: source.Position{line: 1, column: 63} // Adjust column number based on spacing
    }
    assert s.current_token() == expected13

    // Scan illegal character \
    s.advance() // \
    expected14 := token.Token{
        kind: .null,
        lexeme: '\\',
        pos: source.Position{line: 1, column: 73} // Adjust column number based on spacing
    }
    assert s.current_token() == expected14

    // Scan valid identifier
    s.advance() // with
    expected15 := token.Token{
        kind: .ident,
        lexeme: 'with',
        pos: source.Position{line: 1, column: 74} // Adjust column number based on spacing
    }
    assert s.current_token() == expected15

    // Scan illegal character `
    s.advance() // `
    expected16 := token.Token{
        kind: .null,
        lexeme: '`',
        pos: source.Position{line: 1, column: 78} // Adjust column number based on spacing
    }
    assert s.current_token() == expected16

    // Scan valid identifier
    s.advance() // backtick
    expected17 := token.Token{
        kind: .ident,
        lexeme: 'backtick',
        pos: source.Position{line: 1, column: 79} // Adjust column number based on spacing
    }
    assert s.current_token() == expected17
}


