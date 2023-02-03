#!/usr/bin/env bash

ssh-add -d "$HOME/.ssh/act3_ecdsa"

[ -f "$HOME/.ssh/act3_ecdsa" ] && rm "$HOME/.ssh/act3_ecdsa"
[ -f "$HOME/.ssh/act3_ecdsa.pub" ] && rm "$HOME/.ssh/act3_ecdsa.pub" "$HOME/.ssh/act3_ecdsa.pub.bak-$(date +%s)"

