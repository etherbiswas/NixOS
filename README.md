# NixOS: A Productivity Focused and Promgramming-Oriented NixOS Flake

![PwNixOS Logo](pics/PwNixOS.png)

## Getting Started

To get started with NixOS, follow these steps:

1. [Installation](https://nixos.org/manual/nixos/stable/index.html#ch-installation): Install NixOS on your machine by following the official installation guide.
2. Enable Nix-Command and Flakes options: Edit your configuration.nix file located at /etc/nixos/configuration.nix
   adding this line ->
   ```
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```
3. Rebuild your system (without the flake):
   Open a terminal and run ->
   ```
   sudo nixos-rebuild switch
   ```
4. Clone this repo:
   ```
   git clone https://github.com/etherbiswas/NixOS ~/dotfiles
   ```
   rename .git to anything else before introducing new changes.
 5. Edit username: By default, the username for all the configuration is
   `ether` and the hostname is `areo13`. You can change this as you want
   by editing in all the files (don't forget to rename the folder inside hosts).
   `grep -i -R ether ~/.config/nixos/` and `grep -i -R areo13 ~/.config/nixos/` are useful.
 6. Copy your specific hardware-configuration.nix file: You need to copy your
    hardware-configuration.nix file located at /etc/nixos/hardware-configuration.nix
    to the hosts folder. **Always do this on new installs even if same hardware to avoid boot issues.**
 7. Review default.nix file inside hosts folder. It contains the configuration for amd and intel.
    Choose accordingly to your hardware.
 8. Apply the flake: Open a terminal and inside `~/.config/nixos/` run
   ```
   sudo nixos-rebuild switch --flake .#<hostname>
   ```
15. Fingers crossed Reboot!
