{
  pkgs,
  config,
  ...
}: {
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$shell $username:$directory $character ";
    shell = {
      disabled = false;
      format = "$indicator";
      bash_indicator = "[BASH](bright-white)";
      zsh_indicator = "";
    };
    username = {
      disabled = false;
      style_user = "bright-white bold";
      style_root = "bright-red bold";
      format = "[$user]($style)";
      show_always = true;
    };
    character = {
      format = "$symbol";
      vicmd_symbol = "[<](bold green)";
      disabled = false;
      success_symbol = "[->](bold green)";
      error_symbol = "[x](bold red)";
    };
  };
}
