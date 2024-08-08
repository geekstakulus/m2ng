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
    index        int
mut:
    line   int
    column int
}

// new creates a new Source instance initialized with the given text.
pub fn new(text string) Source {
    return Source{
        text: text
        current_char: if text.len > 0 { text[0] } else { `\0` }
        index: 0
        line: 1
        column: 1
    }
}

// advance moves to the next character in the text, updating the current character,
// line, and column information accordingly.
pub fn (mut s Source) advance() {
    if s.current_char == `\n` {
        s.line++
        s.column = 1
    } else {
        s.column++
    }

    s.index++

    if s.index >= s.text.len {
        s.current_char = `\0`
        return
    }

    s.current_char = s.text[s.index]
}

// peek returns the next character in the buffer without moving the index
pub fn (s Source) peek() u8 {
    if s.index + 1 >= s.text.len {
	return `\0`
    }
    return s.text[s.index + 1]
}

// character_position returns the current position (line and column) of the character in the text.
pub fn (s Source) character_position() Position {
    return Position{ line: s.line, column: s.column }
}

