## gravity-defied-cpp-flake

Nix flake package for [gravity_defied_cpp](https://github.com/rgimad/gravity_defied_cpp) - a C++ and SDL2 remake of the Gravity Defied mobile game.

### Run

```bash
nix run github:Luvrok/gravity-defied-cpp-flake
```

### Use in your flake

Add to inputs:

```nix
inputs.gravity-defied-cpp.url = "github:Luvrok/gravity-defied-cpp-flake";
```

Then use:

```nix
inputs.gravity-defied-cpp.packages.${pkgs.system}.default
```

### Notes

- tested only on Xorg, Wayland support is not tested
- game progress is **not saved between sessions**
