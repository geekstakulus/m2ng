module token

import source

// TokenKind represents the different kinds of tokens in Modula-2.
pub enum TokenKind as u8 {
    // Keywords
    null
    div
    mod
    and
    @in
    of
    then
    do
    to
    by
    end
    @else
    elsif
    until
    @if
    while
    repeat
    loop
    with
    exit
    @return
    case
    @for
    array
    pointer
    record
    set
    begin
    code
    @const
    @type
    var
    forward
    procedure
    @module
    definition
    implementation
    export
    qualified
    from
    @import

    // Literals
    int_literal
    real_literal
    string_
    ident
    char_literal

    // Operators
    times
    slash
    plus
    minus
    @or
    eql
    neq
    lss
    leq
    gtr
    geq
    arrow
    not
    becomes

    // Delimiters
    period
    comma
    colon
    ellipsis
    rparen
    rbrak
    rbrace
    lparen
    lbrak
    lbrace
    semicolon
    bar

    // Additional Tokens
    eof
}

// Constants for token group boundaries
const (
    keyword_beg = TokenKind.null
    keyword_end = TokenKind.@import
    literal_beg = TokenKind.int_literal
    literal_end = TokenKind.char_literal
    operator_beg = TokenKind.times
    operator_end = TokenKind.becomes
    delimiter_beg = TokenKind.period
    delimiter_end = TokenKind.bar
    tokens = [
        'NULL', 'DIV', 'MOD', 'AND', 'IN', 'OF', 'THEN', 'DO', 'TO', 'BY',
        'END', 'ELSE', 'ELSIF', 'UNTIL', 'IF', 'WHILE', 'REPEAT', 'LOOP',
        'WITH', 'EXIT', 'RETURN', 'CASE', 'FOR', 'ARRAY', 'POINTER', 'RECORD',
        'SET', 'BEGIN', 'CODE', 'CONST', 'TYPE', 'VAR', 'FORWARD', 'PROCEDURE',
        'MODULE', 'DEFINITION', 'IMPLEMENTATION', 'EXPORT', 'QUALIFIED', 'FROM',
        'IMPORT',
        'INTEGER LITERAL', 'REAL LITERAL', 'STRING', 'IDENT', 'CHARACTER LITERAL',
        '*', '/', '+', '-', 'OR', '=', '#', '<', '<=', '>', '>=', '^', 'NOT', ':=',
        '.', ',', ':', '...', ')', ']', '}', '(', '[', '{', ';', '|',
	'EOF'
    ]
    keywords = {
        'DIV': TokenKind.div,
        'MOD': TokenKind.mod,
        'AND': TokenKind.and,
        'IN': TokenKind.@in,
        'OF': TokenKind.of,
        'THEN': TokenKind.then,
        'DO': TokenKind.do,
        'TO': TokenKind.to,
        'BY': TokenKind.by,
        'END': TokenKind.end,
        'ELSE': TokenKind.@else,
        'ELSIF': TokenKind.elsif,
        'UNTIL': TokenKind.until,
        'IF': TokenKind.@if,
        'WHILE': TokenKind.while,
        'REPEAT': TokenKind.repeat,
        'LOOP': TokenKind.loop,
        'WITH': TokenKind.with,
        'EXIT': TokenKind.exit,
        'RETURN': TokenKind.@return,
        'CASE': TokenKind.case,
        'FOR': TokenKind.@for,
        'ARRAY': TokenKind.array,
        'POINTER': TokenKind.pointer,
        'RECORD': TokenKind.record,
        'SET': TokenKind.set,
        'BEGIN': TokenKind.begin,
        'CODE': TokenKind.code,
        'CONST': TokenKind.@const,
        'TYPE': TokenKind.@type,
        'VAR': TokenKind.var,
        'FORWARD': TokenKind.forward,
        'PROCEDURE': TokenKind.procedure,
        'MODULE': TokenKind.@module,
        'DEFINITION': TokenKind.definition,
        'IMPLEMENTATION': TokenKind.implementation,
        'EXPORT': TokenKind.export,
        'QUALIFIED': TokenKind.qualified,
        'FROM': TokenKind.from,
        'IMPORT': TokenKind.@import,
	'NOT' : TokenKind.not,
	'OR' : TokenKind.@or,
    }
)

// Token represents a token in the source code with its kind, lexeme, and position.
pub struct Token {
    pub:
        kind   TokenKind
        lexeme string
        pos    source.Position
}

// TokenKind methods to check the type of token

// is_keyword checks if the token kind is a keyword
pub fn (tk TokenKind) is_keyword() bool {
    return int(tk) >= int(keyword_beg) && int(tk) <= int(keyword_end)
}

// is_literal checks if the token kind is a literal
pub fn (tk TokenKind) is_literal() bool {
    return int(tk) >= int(literal_beg) && int(tk) <= int(literal_end)
}

// is_operator checks if the token kind is an operator
pub fn (tk TokenKind) is_operator() bool {
    return int(tk) >= int(operator_beg) && int(tk) <= int(operator_end)
}

// is_delimiter checks if the token kind is a delimiter
pub fn (tk TokenKind) is_delimiter() bool {
    return int(tk) >= int(delimiter_beg) && int(tk) <= int(delimiter_end)
}

// lookup returns the TokenKind for a given keyword string, defaulting to ident if not found
pub fn lookup(key string) TokenKind {
    if tk := keywords[key] {
        return tk
    }
    return TokenKind.ident
}
