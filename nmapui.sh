#!/bin/bash

# Check if dialog and nmap are installed
if ! command -v dialog &> /dev/null; then
    echo "dialog could not be found. Please install it and try again."
    exit 1
fi

if ! command -v nmap &> /dev/null; then
    echo "nmap could not be found. Please install it and try again."
    exit 1
fi

# Function to display the main menu
main_menu() {
    cmd=(dialog --menu "netscan by 
    Ashwin kumar" 22 76 16)
    options=(
        1 "Scan a single host"
        2 "Scan a range of IPs"
        3 "Scan a subnet"
        4 "OS detection"
        5 "Service version detection"
        6 "Ping scan"
        7 "Quick scan"
        8 "Aggressive scan"
        9 "Custom Nmap command"
        10 "Exit"
    )
    
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    case $choices in
        1) single_host_scan ;;
        2) range_scan ;;
        3) subnet_scan ;;
        4) os_detection ;;
        5) service_version_detection ;;
        6) ping_scan ;;
        7) quick_scan ;;
        8) aggressive_scan ;;
        9) custom_nmap_command ;;
        10) exit 0 ;;
    esac
}

# Function to scan a single host
single_host_scan() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap $host" 8 40
    nmap $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function to scan a range of IPs
range_scan() {
    range=$(dialog --inputbox "Enter the IP range (e.g., 192.168.1.1-10):" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap $range" 8 40
    nmap $range | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function to scan a subnet
subnet_scan() {
    subnet=$(dialog --inputbox "Enter the subnet (e.g., 192.168.1.0/24):" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap $subnet" 8 40
    nmap $subnet | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for OS detection
os_detection() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap -O $host" 8 40
    nmap -O $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for service version detection
service_version_detection() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap -sV $host" 8 40
    nmap -sV $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for a ping scan
ping_scan() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap -sn $host" 8 40
    nmap -sn $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for a quick scan
quick_scan() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap -T4 -F $host" 8 40
    nmap -T4 -F $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for an aggressive scan
aggressive_scan() {
    host=$(dialog --inputbox "Enter the host IP or domain:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: nmap -A $host" 8 40
    nmap -A $host | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Function for a custom Nmap command
custom_nmap_command() {
    cmd=$(dialog --inputbox "Enter the Nmap command:" 8 40 2>&1 >/dev/tty)
    dialog --msgbox "Running: $cmd" 8 40
    $cmd | tee result.txt
    dialog --textbox result.txt 20 70
    main_menu
}

# Start the main menu
main_menu
