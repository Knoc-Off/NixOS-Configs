{pkgs, config, libs, ...}:
{
  home.file.".ssh/config".text = builtins.readfile ./configs/ssh.conf;
}
