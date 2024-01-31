%{
  open Ast
%}
%token <string> IDENT (*identifier, of type string*)
%token EOF (*eof (special character)*)
%token COLON
%token COMMA
%token EQUAL
%token PROVE // (*prove*)
%token HINT
%token AXIOM
%token LET
%token INDUCTION
%token COMMENT
%token ENDCOMMENT // *)
%token LPAREN
%token RPAREN
%token REC
%start main (*start the parser in main*)
%type <statement list> main
%type <statement> statement
%%


main :
| s = statement ; EOF { [s] }
| s = statement ; list = main { s :: list }
statement :
| COMMENT { Comment }
| LET ; PROVE ; nm = IDENT ; args = argument_list ; EQUAL ; e = expression ; h = hint { Prove(nm,args,e,h) }
| LET ; PROVE ; nm = IDENT ; args = argument_list ; EQUAL ; e = expression { Prove(nm,args,e,No) }
| LET ; REC ; nm = IDENT ; args = argument_list ; EQUAL ; e = expression { Definition(nm,args,e)}
expression :
| e1 = expression ; EQUAL ; e2 = expression { Equality(e1,e2)}
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier(nm) }
| e1 = expression ; nm = IDENT { Application (e1, Identifier(nm)) }
| e1 = expression ; LPAREN ; e2 = expression ; RPAREN { Application (e1, e2)}
argument :
| LPAREN ; nm = IDENT ; COLON ; nm2 = IDENT ; RPAREN { "("^nm^":"^nm2^")" }
argument_list :
| a = argument ; list = argument_list { a::list }
| a = argument { [a] }
hint :
| HINT ; AXIOM ; ENDCOMMENT { Axiom }
| HINT ; INDUCTION ; nm = IDENT ; ENDCOMMENT { Induction(nm) }