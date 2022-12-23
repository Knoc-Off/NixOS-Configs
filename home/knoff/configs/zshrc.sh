# ~/.zshrc

## DirEnv Config
eval "$(direnv hook zsh)"

# Silence Direnv output:
export DIRENV_LOG_FORMAT=

func nixx () { if [[ $1 == "sudo" ]]; then; prog=$2 else; prog=$1; fi;  nix-shell -p "$prog" --run "$(echo $@)" }
PS1=" %F{3}%3~ %f%# "




# Should search for a matching word in apps
function nx () {
  if [ ! $1 ]; then
    exa -T /etc/nixos/
  else
    case $1 in
      rb)
        sudo nixos-rebuild switch
        ;;
      rt)
        sudo nixos-rebuild test
        ;;
      cf)
        file=$(fd . /etc/nixos/modules/home/configs/ -E .git -H | fzf --query "$@")
        if [[ $file == "" ]]; then return; fi
        sudo -E hx "$file"
        ;;
      *)
        file=$(fd . /etc/nixos/ -e nix -E .git -E wireguard-profiles -H | fzf --query "$@")
        if [[ $file == "" ]]; then return; fi
          sudo -E hx "$file"
        ;;
    esac
  fi
}

function nix-shellgen () {
  if [[ ! -f ./.envrc ]]; then 
    echo "use nix" > .envrc;
  fi

  if [[ ! -f ./shell.nix ]]; then 
    printf "{ pkgs ? import <nixpkgs> {},  unstable ? import <unstable> {}}:\npkgs.mkShell {\n  buildInputs = [\n  ];\n  shellHook = ''\n  '';\n}\n" > shell.nix;
  fi
  direnv allow
}


qr () {
  if [[ $1 == "--share" ]]; then
    declare -f qr | qrencode -t UTF8;
  return
  fi
  local S
  if [[ "$#" == 0 ]]; then
    IFS= read -r S
    set -- "$S"
  fi
  echo "${1}" | qrencode -t UTF8
}

