#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
    echo "No hosts to build"
    exit
fi

for host in "$@"; do
    echo "Building for $host"
    nixos-rebuild switch --target-host $host --flake .\#$host --sudo --ask-sudo-password
done
