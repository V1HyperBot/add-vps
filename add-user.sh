SSH_USERNAME=$2
SSH_PASSWORD=$3

sudo adduser --disabled-password --gecos "" $SSH_USERNAME --force-badname
echo "$SSH_USERNAME:$SSH_PASSWORD" | sudo chpasswd
sudo usermod -aG sudo $SSH_USERNAME

clear
echo "SSH login information:"
echo "Username: $SSH_USERNAME"
echo "Password: $SSH_PASSWORD"
echo "Hostname: $$(hostname -I | cut -d' ' -f1)"
echo "Use the above information to connect using PuTTY or any SSH client."
