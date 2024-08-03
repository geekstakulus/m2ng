module scanner

import token
import source
import strings

pub struct Scanner {
    mut:
    src      source.Source
    symbol   token.TokenKind
    position source.Position
    text     strings.Builder
}

pub fn new(src source.Source) Scanner {
    return Scanner{
        src: src,
        symbol: token.TokenKind.eof, // Default to EOF initially
        position: source.Position{line: 1, column: 1},
        text: strings.new_builder(50)
    }
}

pub fn (mut s Scanner) advance() {
    s.skip_whitespace()
    s.position = s.src.character_position()

    match s.src.current_char {
        `+` { s.symbol = .plus }
        `-` { s.symbol = .minus }
        `*` { s.symbol = .times }
        `/` { s.symbol = .slash }
        `,` { s.symbol = .comma }
        `.` { s.symbol = .period }
        `;` { s.symbol = .semicolon }
        `:` { s.symbol = .colon }
        `=` { s.symbol = .eql }
        `(` { s.symbol = .lparen }
        `)` { s.symbol = .rparen }
        `[` { s.symbol = .lbrak }
        `]` { s.symbol = .rbrak }
        `{` { s.symbol = .lbrace }
        `}` { s.symbol = .rbrace }
        else { s.symbol = .null }
    }

    s.text.write_byte(s.src.current_char)
    s.src.advance()
}

pub fn (mut s Scanner) skip_whitespace() {
    for s.src.current_char in [` `, `\t`, `\n`, `\r`] {
        s.src.advance()
    }
}

pub fn (mut s Scanner) current_token() token.Token {
    return token.Token{
        kind: s.symbol,
        pos: s.position,
        lexeme: s.text.str()
    }
}

