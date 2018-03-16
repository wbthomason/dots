open Cmdliner

let patch mod_name = Printf.printf "add patches to %s!" mod_name
let unpatch mod_name = Printf.printf "remove patches from %s!" mod_name

let patch_cmd = 
  let mod_name = 
    let doc = "Patch module $(docv)" in
    Arg.(required & pos 0 (some dir) None & info [] ~docv:"MODULE" ~doc)
  in
  let doc = "Record the current changes to the given module as a new patch" in
  let exits = Term.default_exits in
  let man = [
    `S Manpage.s_description;
    `P "Take the current diff of the given module as a new patch for the module, and undo the
    changes in your VCS";]
  in
  Term.(const patch $ mod_name), Term.info "patch" ~doc ~exits ~man

let unpatch_cmd = 
  let mod_name = 
    let doc = "Unpatch module $(docv)" in
    Arg.(required & pos 0 (some dir) None & info [] ~docv:"MODULE" ~doc)
  in
  let doc = "Remove the current patch for the given module" in
  let exits = Term.default_exits in
  let man = [
    `S Manpage.s_description;
    `P "Remove the given module's current patch from your patch set";]
  in
  Term.(const unpatch $ mod_name), Term.info "unpatch" ~doc ~exits ~man
