(*define data types here*)
(*What are the other data types supposed to be??*)
type expression =
(*= Match of *)
| Application of expression * expression
| Identifier of string
| Equality of expression * expression

type hint = 
| Axiom
| No
| Induction of string

type statement = 
| Prove of (string * string list * expression * hint)
| Definition of (string * string list * expression)
| Comment
