(*let parse (s : string) : string list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
     ast*)

include Ast
module Parser = Parser
module Lexer = Lexer

let parse (s : string) : statement list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
  ast


let string_of_hint (h : hint) : string = match h with
| Axiom -> "(* hint: axiom *)"
| No -> "(* no hint *)"
| Induction (s) -> "(* hint: induction on " ^ s ^ " *)"

let rec string_of_expression (e : expression) : string =
  match e with
  | Identifier nm -> nm
  | Application (e1,e2) -> "(" ^ (string_of_expression e1) ^ " " ^ (string_of_expression e2) ^ ")"
  | Equality (e1,e2) -> "(" ^ (string_of_expression e1) ^ " = " ^ (string_of_expression e2) ^ ")"

let string_of_statement (s : statement) : string = match s with
  | Prove(s1,args,e,h) -> "let (*prove*) " ^ s1 ^ " " ^ (String.concat " " args) ^"\n= " ^ (string_of_expression e) ^" \n"^ (string_of_hint h) ^ "\n"
  | Definition(s1,args,e) -> s1 ^ (String.concat " " args) ^ (string_of_expression e) ^ "\n"
  | Comment -> "comment was here"
