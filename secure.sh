#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <enc|dec> <filename>"
    exit 1
fi

operation=$1
filename=$2

if [ "$operation" == "enc" ]; then
    # Encrypt the file
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$filename" -out "$filename.enc"

    # Check if encryption was successful
    if [ $? -eq 0 ]; then
        # Remove the original file securely
        shred -u "$filename"
        echo "Encryption complete. Original file securely deleted."
    else
        echo "Encryption failed. Original file not deleted."
        exit 1
    fi

elif [ "$operation" == "dec" ]; then
    # Decrypt the file
    openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$filename" -out "${filename%.enc}"

    # Check if decryption was successful
    if [ $? -eq 0 ]; then
        # Remove the encrypted file securely
        shred -u "$filename"
        echo "Decryption complete. Encrypted file securely deleted."
    else
        echo "Decryption failed. Encrypted file not deleted."
        exit 1
    fi

else
    echo "Invalid operation. Use 'encrypt' or 'decrypt'."
    exit 1
fi
