open Cmdliner

let use_layer layer_name = Printf.printf "use layer %s!" layer_name

let use_layer_cmd = 
  let layer_name = 
    let doc = "Use layer $(docv)" in
    Arg.(value & pos 0 string "default" & info [] ~docv:"LAYER" ~doc)
  in
  let doc = "Use a layer defined in the .dots file" in
  let exits = Term.default_exits in
  let man = [
    `S Manpage.s_description;
    `P "Switch to the given layer, asking to create a new layer if it doesn't exist";]
  in
  Term.(const use_layer $ layer_name), Term.info "use" ~doc ~exits ~man
