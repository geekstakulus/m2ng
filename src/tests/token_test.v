import token

fn test_is_keyword() {
    assert token.TokenKind.null.is_keyword()
    assert token.TokenKind.div.is_keyword()
    assert !token.TokenKind.int_literal.is_keyword()
    assert !token.TokenKind.plus.is_keyword()
    assert !token.TokenKind.period.is_keyword()
    assert !token.TokenKind.eof.is_keyword()
}

fn test_is_literal() {
    assert token.TokenKind.int_literal.is_literal()
    assert token.TokenKind.real_literal.is_literal()
    assert token.TokenKind.string_.is_literal()
    assert token.TokenKind.ident.is_literal()
    assert !token.TokenKind.null.is_literal()
    assert !token.TokenKind.plus.is_literal()
    assert !token.TokenKind.period.is_literal()
    assert !token.TokenKind.eof.is_literal()
}

fn test_is_operator() {
    assert token.TokenKind.times.is_operator()
    assert token.TokenKind.slash.is_operator()
    assert token.TokenKind.plus.is_operator()
    assert token.TokenKind.minus.is_operator()
    assert token.TokenKind.eql.is_operator()
    assert token.TokenKind.neq.is_operator()
    assert !token.TokenKind.int_literal.is_operator()
    assert !token.TokenKind.real_literal.is_operator()
    assert !token.TokenKind.null.is_operator()
    assert !token.TokenKind.period.is_operator()
    assert !token.TokenKind.eof.is_operator()
}

fn test_is_delimiter() {
    assert token.TokenKind.period.is_delimiter()
    assert token.TokenKind.comma.is_delimiter()
    assert token.TokenKind.colon.is_delimiter()
    assert token.TokenKind.rparen.is_delimiter()
    assert token.TokenKind.lparen.is_delimiter()
    assert token.TokenKind.semicolon.is_delimiter()
    assert !token.TokenKind.int_literal.is_delimiter()
    assert !token.TokenKind.real_literal.is_delimiter()
    assert !token.TokenKind.plus.is_delimiter()
    assert !token.TokenKind.null.is_delimiter()
    assert !token.TokenKind.eof.is_delimiter()
}

// Test the token.lookup function
fn test_lookup() {
    // Test all known keywords
    assert token.lookup('IF') == .@if
    assert token.lookup('WHILE') == .while
    assert token.lookup('REPEAT') == .repeat
    assert token.lookup('LOOP') == .loop
    assert token.lookup('WITH') == .with
    assert token.lookup('EXIT') == .exit
    assert token.lookup('RETURN') == .@return
    assert token.lookup('CASE') == .case
    assert token.lookup('FOR') == .@for
    assert token.lookup('ARRAY') == .array
    assert token.lookup('POINTER') == .pointer
    assert token.lookup('RECORD') == .record
    assert token.lookup('SET') == .set
    assert token.lookup('BEGIN') == .begin
    assert token.lookup('CODE') == .code
    assert token.lookup('CONST') == .@const
    assert token.lookup('TYPE') == .@type
    assert token.lookup('VAR') == .var
    assert token.lookup('FORWARD') == .forward
    assert token.lookup('PROCEDURE') == .procedure
    assert token.lookup('MODULE') == .@module
    assert token.lookup('DEFINITION') == .definition
    assert token.lookup('IMPLEMENTATION') == .implementation
    assert token.lookup('EXPORT') == .export
    assert token.lookup('QUALIFIED') == .qualified
    assert token.lookup('FROM') == .from
    assert token.lookup('IMPORT') == .@import
    assert token.lookup('UNTIL') == .until
    assert token.lookup('ELSE') == .@else
    assert token.lookup('ELSIF') == .elsif
    assert token.lookup('END') == .end
    assert token.lookup('THEN') == .then
    assert token.lookup('OF') == .of
    assert token.lookup('DO') == .do
    assert token.lookup('TO') == .to
    assert token.lookup('BY') == .by
    assert token.lookup('IN') == .@in
    assert token.lookup('NOT') == .not
    assert token.lookup('DIV') == .div
    assert token.lookup('MOD') == .mod
    assert token.lookup('AND') == .and
    assert token.lookup('OR') == .@or

    // Test string that is not a keyword but should be an identifier
    assert token.lookup('MY_VARIABLE') == .ident
    assert token.lookup('var1') == .ident
    assert token.lookup('myvar') == .ident
}
