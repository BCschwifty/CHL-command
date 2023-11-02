#!/bin/bash

# Function to set the Bash prompt color
set_prompt_color() {
    local color_code="$1"
    PS1="\[\e[${color_code}m\]\u\[\e[0m\]@\h:\w\$ "
}

# Function to map color names to color codes
get_color_code() {
    local color_name="$1"
    case "$color_name" in
        "black") echo "30" ;;
        "red") echo "31" ;;
        "green") echo "32" ;;
        "yellow") echo "33" ;;	
        "blue") echo "34" ;;
        "magenta") echo "35" ;;
        "cyan") echo "36" ;;
        "white") echo "37" ;;
        *) echo "$color_name is not a valid color name."; exit 1 ;;
    esac
}

# Main script
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <user_color> <root_color>"
    echo "Available color names: black, red, green, yellow, blue, magenta, cyan, white"
    exit 1
fi

user_color="$1"
root_color="$2"

# Get color codes for the provided color names
user_color_code=$(get_color_code "$user_color")
root_color_code=$(get_color_code "$root_color")

# Set the prompt color for the regular user
set_prompt_color "$user_color_code"

# Check if the user is root and set the prompt color accordingly
if [ "$(whoami)" = "root" ]; then
    set_prompt_color "$root_color_code"
fi

# Apply the changes to the current session
source ~/.bashrc

# Check if the script is run as 'su'
if [ -n "$SU_USER" ]; then
    echo "Switched to root user. Root user's color set to $root_color."
else
    echo "Regular user's color set to $user_color."
fi