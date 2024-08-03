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
