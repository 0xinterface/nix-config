set positional-arguments

default:
  @just --list

deploy *args:
  #!/usr/bin/env sh
  set -eu

  darwin=false
  boot=false
  user="admin"
  target=""
  hostname=""

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --darwin)
        darwin=true
        shift
        ;;
      --boot)
        boot=true
        shift
        ;;
      --target)
        [ "$#" -ge 2 ] || { echo "error: --target requires a value" >&2; exit 1; }
        target="$2"
        shift 2
        ;;
      -h|--help)
        echo "Usage:"
        echo "  just deploy HOST"
        echo "  just deploy --darwin HOST"
        echo "  just deploy --boot HOST"
        echo "  just deploy --boot HOST --target SSH_HOST"
        exit 0
        ;;
      --*)
        echo "error: unknown option: $1" >&2
        exit 1
        ;;
      *)
        if [ -z "$hostname" ]; then
          hostname="$1"
        else
          echo "error: unexpected extra argument: $1" >&2
          exit 1
        fi
        shift
        ;;
    esac
  done

  if [ -z "$hostname" ]; then
    echo "error: hostname is required" >&2
    echo "Try one of:"
    echo "  just deploy my-nixos-host"
    echo "  just deploy --darwin my-mac"
    echo "  just deploy --boot my-nixos-host"
    exit 1
  fi

  if [ "$darwin" = true ] && [ "$boot" = true ]; then
    echo "error: use either --darwin or --boot, not both" >&2
    exit 1
  fi

  if [ -z "$target" ]; then
    target="$hostname"
  fi

  if [ "$darwin" = true ]; then
    exec sudo darwin-rebuild switch --flake ".#${hostname}"
  elif [ "$boot" = true ]; then
    exec nix run nixpkgs#nixos-rebuild -- \
      --no-reexec \
      --flake ".#${hostname}" \
      --target-host "${user}@${target}" \
      --build-host "${user}@${target}" \
      --sudo \
      --ask-sudo-password \
      boot
  else
    exec nix run github:serokell/deploy-rs -- "#${hostname}.system"
  fi
