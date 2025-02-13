export def main () {
    sudo mkdir /run/systemd/system/nix-daemon.service.d/
    sudo cp ~/override.conf /run/systemd/system/nix-daemon.service.d/
    sudo systemctl daemon-reload
    sudo systemctl restart nix-daemon
}