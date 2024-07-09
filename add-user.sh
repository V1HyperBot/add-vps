ACTION=$1
CHAT_ID=$2
SSH_USERNAME=$3
SSH_PASSWORD=$4
BOT_TOKEN="7419614345:AAFwmSvM0zWNaLQhDLidtZ-B9Tzp-aVWICA"

send_telegram_message() {
    local MESSAGE=$1
    local REPLY_MARKUP='{
        "inline_keyboard": [
            [
                {
                    "text": "Powered By",
                    "url": "https://t.me/NorSodikin"
                }
            ]
        ]
    }'
    
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE" \
    -d parse_mode="Markdown" \
    -d reply_markup="$REPLY_MARKUP"
    clear 
}


case $ACTION in
  add)
    sudo adduser --disabled-password --gecos "" $SSH_USERNAME --force-badname
    echo "$SSH_USERNAME:$SSH_PASSWORD" | sudo chpasswd
    sudo usermod -aG sudo $SSH_USERNAME

    HOSTNAME=$(hostname -I | cut -d' ' -f1)
    MESSAGE="SSH login information:%0A%0AUsername: $SSH_USERNAME%0APassword: $SSH_PASSWORD%0AHostname: $HOSTNAME%0A%0AUse the above information to connect using PuTTY or any SSH client."

    send_telegram_message "$MESSAGE"

    echo -e "SSH login information:\n\nUsername: $SSH_USERNAME\nPassword: $SSH_PASSWORD\nHostname: $HOSTNAME\n\nUse the above information to connect using PuTTY or any SSH client."
    ;;

  delete)
    sudo usermod --expiredate 1 $SSH_USERNAME
    sudo deluser --remove-home $SSH_USERNAME

    MESSAGE="User $SSH_USERNAME has been deleted from the system and can no longer log in."
    
    send_telegram_message "$MESSAGE"

    echo -e "User $SSH_USERNAME has been deleted from the system and can no longer log in."
    ;;

  *)
    echo "Invalid action. Use 'add' to add a user or 'delete' to delete a user."
    ;;
esac
