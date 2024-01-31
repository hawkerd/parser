{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf }
 | '(' { LPAREN }
 | ')' { RPAREN }
 | ',' { COMMA }
 | '=' { EQUAL }
 | "(*prove*)" { PROVE }
 | "(* hint:" { HINT }
 | "(*hint:" { HINT }
 | "induction on" { INDUCTION }
 | "*)" { ENDCOMMENT }
 | "(*" { comment_skip lexbuf }
 | ':' { COLON }
 | "axiom" { AXIOM }
 | "let" { LET }
 | ['a'-'z' 'A'-'Z' '0'-'9' '_' '\'']+ as word { 
    match word with
    | "axiom" -> AXIOM
    | "let" -> LET
    | "rec" -> REC
    | _ -> IDENT(word) }
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }
and comment_skip = parse
| "*)" {Lexing.new_line lexbuf; token lexbuf}
| eof { EOF }
| _ { comment_skip lexbuf }
