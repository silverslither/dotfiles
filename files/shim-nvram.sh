#!/usr/bin/env bash

efibootmgr --unicode --disk $(df --output="source" / | grep "/dev" | sed "s/p.//") --part 1 --create --label "Shim" --loader /EFI/GRUB/shimx64.efi
