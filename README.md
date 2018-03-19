# dots
Manage dotfiles with system-specific changes.

## Planning
- There are **layers** for different systems
- Layers have **modules** representing the configs to be managed
- Layers can also have **patches** for modules specifying how to change the config for the particular system
- Modules are specified just like for GNU `stow`
- We handle patches without cluttering git by computing the inverse of a diff to apply to undo a patch and doing some yet-to-be-determined magic to make git not mark the configs as modified.
  - Maybe clever use of a hidden directory with copies of the original files and .gitignore modifications to hide changes to the "real" files? We'd need to be careful with synchronization and have a plan for undoing this setup to move away from the `dots` tool.
