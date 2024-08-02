module source

// Position holds the line and column information for the current character in the text.
pub struct Position {
    pub:
        line   int
        column int
}

// Source represents a reader that processes a string character by character.
pub struct Source {
pub mut:
    text         string
    current_char u8
    position     Position
    index        int
}

// new creates a new Source instance initialized with the given text.
pub fn new(text string) Source {
    return Source{
        text: text
        current_char: if text.len > 0 { text[0] } else { `\0` }
        position: Position{ line: 1, column: 1 }
        index: 0
    }
}

// advance moves to the next character in the text, updating the current character,
// line, and column information accordingly.
pub fn (mut s Source) advance() {
    s.index++
    if s.index >= s.text.len {
        s.current_char = `\0`
        return
    }
    s.current_char = s.text[s.index]

    if s.current_char == `\n` {
        s.position = Position{ line: s.position.line + 1, column: 0 }
    } else {
        s.position = Position{ line: s.position.line, column: s.position.column + 1 }
    }
}

