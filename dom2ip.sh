#!/bin/bash
#Trust me, this code is made with love

echo "
    _______
   //  _   /
  //       \\
 /    __   / Bulk domain to ip
 \\________/ Coded by putunebandi
"

if [ "$#" -ne 2 ]; then
    echo " Use: $(basename "$0") input.txt output.txt"
    exit 1
fi

input_file=$1
output_file=$2

if [ ! -e "$input_file" ]; then
    echo " Failed: File $input_file not found."
    exit 1
fi

while read -r domain; do
    ip=$(nslookup $domain | grep 'Address' | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | awk 'NR==2{print}')
    if [ -n "$ip" ]; then
        echo " Domain: $domain, IP: $ip"
        echo "$domain => $ip" >> "$output_file"
    else
        echo " Domain: $domain, IP: [ADDR ERROR]"
        echo "$domain => [ADDR ERROR]" >> "$output_file"
    fi
done < "$input_file"
