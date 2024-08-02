import source

fn test_initial_state() {
    mut reader := source.new('Hello, World!')
    assert reader.current_char == `H`
    assert reader.position.line == 1
    assert reader.position.column == 1
}

fn test_advance() {
    mut reader := source.new('Hello, World!')
    reader.advance()
    assert reader.current_char == `e`
    assert reader.position.line == 1
    assert reader.position.column == 2
}

fn test_advance_newline() {
    mut reader := source.new('Hello\nWorld!')
    reader.advance() // H
    reader.advance() // e
    reader.advance() // l
    reader.advance() // l
    reader.advance() // o
    reader.advance() // \n
    assert reader.current_char == `W`
    assert reader.position.line == 2
    assert reader.position.column == 1
}

fn test_end_of_file() {
    mut reader := source.new('Hi')
    reader.advance() // H
    reader.advance() // i
    reader.advance() // EOF
    assert reader.current_char == `\0`
}

