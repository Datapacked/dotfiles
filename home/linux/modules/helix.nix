{
  inputs,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "hx";
  home.packages = with pkgs; [nil];

  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "python";
          language-servers = [{name = "pylsp";}];
        }
        {
          name = "swift";
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
            }
          ];
        }
        {
          name = "svelte";
          language-servers = [
            {
              name = "svelteserver";
            }
          ];
        }
        {
          auto-format = true;
          formatter.command = "shfmt";
          name = "bash";
        }
        {
          auto-format = true;
          name = "rust";
          roots = ["flake.nix"];
        }
        {
          auto-format = true;
          name = "haskell";
          roots = ["flake.nix"];
        }
        {
          auto-format = true;
          formatter.command = "alejandra";
          language-servers = ["nil"];
          name = "nix";
        }
        {
          auto-format = true;
          formatter.command = "typstfmt";
          name = "typst";
        }
        {
          auto-format = true;
          formatter.args = ["-in"];
          formatter.command = "yamlfmt";
          name = "yaml";
        }
      ];
      language-server = {
        pylsp = {
          command = "pylsp";
        };
        typescript-language-server = {
          command = "tsserver";
        };
      };
    };
    package = inputs.helix.packages.${pkgs.system}.default;
    settings = {
      editor = {
        auto-format = true;
        auto-save = true;
        line-number = "absolute";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };

      theme = "base16_transparent";
    };
  };
}
