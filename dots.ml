open Cmdliner
open Git
open Layer
open Patch
open Dotmodule

(* Adapted from the Cmdliner docs *)
let help man_format cmds topic = match topic with
| None -> `Help (`Pager, None)
| Some topic ->
    let topics = "topics" :: cmds in
    let conv, _ = Cmdliner.Arg.enum (List.rev_map (fun s -> (s, s)) topics) in
    match conv topic with
    | `Error e -> `Error (false, e)
    | `Ok t when t = "topics" -> List.iter print_endline topics; `Ok ()
    | `Ok t when List.mem t cmds -> `Help (man_format, Some t)
    | `Ok t ->
        let page = (topic, 7, "", "", ""), [`S topic; `P "Say something";] in
        `Ok (Cmdliner.Manpage.print man_format Format.std_formatter page)

let help_sections = [
 `P "Use `$(mname) $(i,COMMAND) --help' for help on a single command.";`Noblank;
 `S Manpage.s_bugs; `P "Check bug reports at https://github.com/wbthomason/dots/issues.";]

let help_cmd =
  let topic =
    let doc = "The topic to get help on. `topics' lists the topics." in
    Arg.(value & pos 0 (some string) None & info [] ~docv:"TOPIC" ~doc)
  in
  let doc = "Display help for using dots" in
  let man =
    [`S Manpage.s_description;
     `P "Prints help about dots";
     `Blocks help_sections; ]
  in
  Term.(ret (const help $ Arg.man_format $ Term.choice_names $ topic)),
  Term.info "help" ~doc ~exits:Term.default_exits ~man

let cmd =
  let doc = "Manage dotfiles with system-dependent differences" in
  let exits = Term.default_exits in
  let man = help_sections in
  Term.(ret (const (`Help (`Plain, None)))),
  Term.info "dots" ~version:"v0.1.0" ~doc ~exits ~man

let cmds = [use_layer_cmd; patch_cmd; unpatch_cmd; add_module_cmd; remove_module_cmd; help_cmd]

let () = Term.(exit @@ eval_choice cmd cmds)
