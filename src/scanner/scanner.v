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
        text: strings.new_builder(100)
    }
}

pub fn (mut s Scanner) advance() {
    s.skip_whitespace()
    match s.src.current_char {
        `+`, `-`, `*`, `/`, `%`, `&`, `#`, `=` {
            s.scan_operator()
        }
        `(`, `)`, `{`, `}`, `[`, `]`, `,`, `.`, `;`, `:`, 0x7f {
            s.scan_delimiter()
        }
        `0`...`9` {
            s.scan_number()
        }
        else {
            s.scan_identifier_or_keyword()
        }
    }
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

fn (mut s Scanner) scan_operator() {
    match s.src.current_char {
        `+` { s.symbol = .plus }
        `-` { s.symbol = .minus }
        `*` { s.symbol = .times }
        `/` { s.symbol = .slash }
        `%` { s.symbol = .null }
        `&` { s.symbol = .and }
        `#` { s.symbol = .neq }
        `=` { s.symbol = .eql }
        else { s.symbol = .null }
    }
    s.position = s.src.character_position()
    s.text.write_byte(s.src.current_char)
    s.src.advance()
}

fn (mut s Scanner) scan_delimiter() {
    match s.src.current_char {
        `(` { s.symbol = .lparen }
        `)` { s.symbol = .rparen }
        `{` { s.symbol = .lbrace }
        `}` { s.symbol = .rbrace }
        `[` { s.symbol = .lbrak }
        `]` { s.symbol = .rbrak }
        `,` { s.symbol = .comma }
        `.` {
	    if s.src.peek() == `.` {
		s.text.write_byte(s.src.current_char)
		s.src.advance()
		s.symbol = .ellipsis
	    } else {
		s.symbol = .period
	    }
	}
        `;` { s.symbol = .semicolon }
        `:` { s.symbol = .colon }
        `\0` { s.symbol = .eof }
        0x7f {
	    s.symbol = .ellipsis
	    s.text.write_string('..')
	    s.position = source.Position{
		line: s.src.character_position().line,
		column: s.src.character_position().column - 1
	    }
	    return
	}
        else { s.symbol = .null }
    }

    s.position = s.src.character_position()
    s.text.write_byte(s.src.current_char)
    s.src.advance()
}


// scan_number scans an integer or real number from the source.

fn (mut s Scanner) scan_number() {
    s.symbol = .int_literal
    s.position = s.src.character_position()

    // Collect digits, including octal and hexadecimal
    for (s.src.current_char >= `0` && s.src.current_char <= `9`) ||
        (s.src.current_char >= `A` && s.src.current_char <= `F`) ||
        (s.src.current_char >= `a` && s.src.current_char <= `f`) {
        s.text.write_byte(s.src.current_char)
        s.src.advance()
    }

    // Check for ellipsis '..'
    if s.src.current_char == `.` {
        s.src.advance()
        if s.src.current_char == `.` {
            s.src.current_char = 0x7f
            return
        }

	// decimal point
        s.text.write_byte(`.`)

        // Collect digits after decimal point
        for s.src.current_char >= `0` && s.src.current_char <= `9` {
            s.text.write_byte(s.src.current_char)
            s.src.advance()
        }

        // Check for exponent
        if s.src.current_char == `E` || s.src.current_char == `e` {
            s.text.write_byte(s.src.current_char)
            s.src.advance()

            if s.src.current_char == `+` || s.src.current_char == `-` {
                s.text.write_byte(s.src.current_char)
                s.src.advance()
            }

            for s.src.current_char >= `0` && s.src.current_char <= `9` {
                s.text.write_byte(s.src.current_char)
                s.src.advance()
            }
        }

        s.symbol = .real_literal
        s.text.write_string(s.text.str())
        return
    }

    // Check for integer suffixes indicating base
    if s.src.current_char == `B` || s.src.current_char == `C` || s.src.current_char == `D` || s.src.current_char == `H` {
        //last_ch := s.src.current_char
        s.symbol = .int_literal
	s.text.write_byte(s.src.current_char)
        s.src.advance()

    }
}

fn (mut s Scanner) scan_identifier_or_keyword() {
    s.symbol = .ident
    s.position = s.src.character_position()
    s.text.clear()

    for (s.src.current_char >= `a` && s.src.current_char <= `z`) ||
        (s.src.current_char >= `A` && s.src.current_char <= `Z`) ||
        (s.src.current_char >= `0` && s.src.current_char <= `9`) {
        s.text.write_byte(s.src.current_char)
        s.src.advance()
    }

    keyword := s.text.str()
    if token.lookup(keyword) != .ident {
        s.symbol = token.lookup(keyword)
    }

    s.text.write_string(keyword)
}
