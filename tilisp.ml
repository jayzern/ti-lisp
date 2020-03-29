open Ast

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let program = Parser.program Scanner.token lexbuf in
  let expanded = Macro.expand_all program in
  let program = Semant.check expanded in
  print_endline
    (String.concat "\n\n"
       (List.filter
          (fun x -> String.length x > 0)
          (Sast.string_of_stmt_block program)))
