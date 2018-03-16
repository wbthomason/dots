open Cmdliner

let add mod_name = Printf.printf "add module %s" mod_name
let remove mod_name = Printf.printf "remove module %s" mod_name

let add_module_cmd = 
  let mod_name = 
    let doc = "Add module $(docv)" in
    Arg.(required & pos 0 (some dir) None & info [] ~docv:"MODULE" ~doc)
  in
  let doc = "Add a module to the current layer" in
  let exits = Term.default_exits in
  let man = [
    `S Manpage.s_description;
    `P "Add a module in a directory with the given name to the current layer";]
  in
  Term.(const add $ mod_name), Term.info "add" ~doc ~exits ~man

let remove_module_cmd = 
  let mod_name = 
    let doc = "Remove module $(docv)" in
    Arg.(required & pos 0 (some string) None & info [] ~docv:"MODULE" ~doc)
  in
  let doc = "Remove a module from the current layer" in
  let exits = Term.default_exits in
  let man = [
    `S Manpage.s_description;
    `P "Remove the given module from the current layer";]
  in
  Term.(const remove $ mod_name), Term.info "remove" ~doc ~exits ~man
