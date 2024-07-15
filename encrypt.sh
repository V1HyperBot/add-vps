encrypt_code() {
    local code="$1"
    local key="$2"
    local encoded
    local compressed
    local encrypted

    encoded=$(echo "$code" | base64 | tr -d '\n')
    compressed=$(echo "$encoded" | gzip | base64 | tr -d '\n')
    encrypted=$(echo "$compressed$key" | base64 | tr -d '\n')
    echo "$encrypted"
}

decrypt_code() {
    local encrypted="$1"
    local key="$2"
    local decrypted
    local compressed
    local stored_key
    local encoded
    local code

    decrypted=$(echo "$encrypted" | base64 --decode)
    compressed="${decrypted:0:${#decrypted}-${#key}}"
    stored_key="${decrypted:${#decrypted}-${#key}}"

    if [[ "$stored_key" != "$key" ]]; then
        echo "Invalid key"
        exit 1
    fi

    encoded=$(echo "$compressed" | base64 --decode | gunzip)
    code=$(echo "$encoded" | base64 --decode)
    echo "$code"
}

if [[ $# -ne 3 ]]; then
    echo "Usage: bash encrypt.sh choice encrypted_code key"
    exit 1
fi

choice="$1"
encrypted_code="$2"
key="$3"

case $choice in
    encrypt)
        encrypted_code=$(encrypt_code "$encrypted_code" "$key")
        echo "$encrypted_code"
        ;;
    decrypt)
        decrypted_code=$(decrypt_code "$encrypted_code" "$key")
        echo "$decrypted_code"
        ;;
    *)
        echo "Invalid choice. Please specify 'encrypt' or 'decrypt'."
        exit 1
        ;;
esac
