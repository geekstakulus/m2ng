import source

fn test_initial_state() {
    mut reader := source.new('Hello, World!')
    assert reader.current_char == `H`
    pos := reader.character_position()
    assert pos.line == 1
    assert pos.column == 1
}

fn test_advance() {
    mut reader := source.new('Hello, World!')
    reader.advance()
    assert reader.current_char == `e`
    pos := reader.character_position()
    assert pos.line == 1
    assert pos.column == 2
}

fn test_advance_newline() {
    mut reader := source.new('Hello\nWorld!')
    reader.advance() // e
    reader.advance() // l
    reader.advance() // l
    reader.advance() // o
    reader.advance() // \n
    assert reader.current_char == `\n`
    mut pos := reader.character_position()
    assert pos.line == 1
    assert pos.column == 6
    reader.advance() // W
    assert reader.current_char == `W`
    pos = reader.character_position()
    assert pos.line == 2
    assert pos.column == 1
}

fn test_end_of_file() {
    mut reader := source.new('Hi')
    reader.advance() // H
    reader.advance() // i
    reader.advance() // EOF
    assert reader.current_char == `\0`
}

