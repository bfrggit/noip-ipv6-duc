# noip-ipv6-duc

Linux DUC for IPv6 on No-IP

## Usage

1. Update the values in the script, particularly `user`, `pass`, and `hostname`.
1. Put the script in `/usr/local/bin`
1. Put the service in `/etc/systemd/system`
1. `sudo systemctl daemon-reload ; sudo systemctl enable noip-duc ; sudo systemctl start noip-duc`

I make no guarantees about the reliability of this script. To avoid getting banned, it errs on the side of failing.
