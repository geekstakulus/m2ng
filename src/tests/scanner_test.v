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
    src := source.new('identifier anotherIdentifier 123number')
    mut s := scanner.new(src)

    // Scan identifiers
    s.advance() // identifier
    expected1 := token.Token{
        kind: .ident,
        lexeme: 'identifier',
        pos: source.Position{line: 1, column: 1}
    }
    assert s.current_token() == expected1

    s.advance() // anotherIdentifier
    expected2 := token.Token{
        kind: .ident,
        lexeme: 'anotherIdentifier',
        pos: source.Position{line: 1, column: 12} // Adjust column number based on spacing
    }
    assert s.current_token() == expected2

    s.advance() // 123number (treated as identifier in this case)
    expected3 := token.Token{
        kind: .int_literal,
        lexeme: '123',
        pos: source.Position{line: 1, column: 30} // Adjust column number based on spacing
    }
    assert s.current_token() == expected3

    s.advance() // 123number (treated as identifier in this case)
    expected4 := token.Token{
        kind: .ident,
        lexeme: 'number',
        pos: source.Position{line: 1, column: 33} // Adjust column number based on spacing
    }
    assert s.current_token() == expected4
}

