#!/bin/bash

salt '*' cmd.run 'mkdir /home/datayes/.ssh'

salt '*' cmd.run 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tJfoY7vLEJPqX0+xMxS9sWOz6dB5mLZh8ST2PsO0F2zYVhAqDc4Oy1k+WCCpvNcKdhyMvRcGc0qeAexPTMimpCBGOVXV5Zr/QvNQm8/Rw9r9F55alkaFFMgWSY76tCSoFP5r89m9YIBxcCnzjjUyO+QL3B0wnI/y2Umwv8IaCzH5S/qcxmVdw/YH+Zk1y2nMqD+VG/KvLUEcPaU5uVr5pliiMLlOqSxasZiGielu0zX3NZkd2iDa16vwZ1hgmv1F5DQpsvHp7TS0xL8eyxygEkPzTnnx40TM8vpCWwJGexsnmbALa/9titxo698S4w7oGnVZSvAW1RKQRLP0BTb7" > /home/datayes/.ssh/authorized_keys'

salt '*' cmd.run 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsTHDiIFfwq+51F/H/PlBK8igEXt0bNQvcja7Eb6+mGNHLRY4nqbKRKgjLggG08VYTLsC5be0KaSDrzUn/20iko39grRQVG+iIGS6EzHOYbLhLp8vX+AjH/6xCwgAGzIlzJnAgXiwcuorB6ADMBXuo+b4p2ZIvWHf9v2K+WbssZAEznsBPXp6TtdYzJJn1w2NwdN7VE2nqsxKSVK+2osROUUlJ2R4dIPNhOMR8fOhI4a1ieavoJJlyI+TqL6wuaPSH+qt+YWT0dmU7lbygY9xMzhx27QfwKjBK2sT6eknP+D12ghOVvy10rCz6r865X5Hnv64piSTn6oYX/0JH+Lnz alex@mba" >> /home/datayes/.ssh/authorized_keys'

salt '*' cmd.run 'chown datayes:datayes /home/datayes/.ssh'

salt '*' cmd.run 'sed -i "s/Port 22/Port 8022/g" /etc/ssh/sshd_config ; restart ssh'

salt '*' cmd.run 'echo "datayes ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/datayes'
