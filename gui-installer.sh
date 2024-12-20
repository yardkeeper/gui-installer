#!/bin/bash
current_dir=$(pwd)


wls_gui_deps="${current_dir}/wls-gui-deps"
gui_deps="${current_dir}/gui-deps"
api_files="${current_dir}/api-files"





function check_server() {
    while true; do
        ping -c 2 192.168.1.2 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "\033[31mThe server is unavailable. Please check the connection\033[0m"
            read -p "Press 1 to continue, or any other key to exit.: " key
            if [ "$key" != "1" ]; then
                exit 1
            fi
        else
            echo -e "\033[32mServer is available.\033[0m"
            break
        fi
    done
}

export -f check_server


function install_packages() {
    dir=$1
    
    if [[ ! -d "$dir" ]]; then
        echo "Error: Folder '$dir' does not exist."
        exit 1
    else
        
        sudo dpkg -i --force-all  $dir/*.deb
    fi
    
}

export -f install_packages

folders=($api_files $gui_deps)


while true; do
    echo "Installation options:"
    echo ""
    echo "1 - Install GUI for Windows Subsystem for Linux"
    echo "2 - Install  GUI for Linux"
    echo "3 - Install API"
    echo "r - Remove all installed packages"
    read choice
    
    case "$choice" in
        1)
            echo -e "\033[31mIs not implemented yet\033[0m"
            
        ;;
        2)
            install_packages "$gui_deps"
            sudo dpkg -i 6.2.4-x86_64.deb
            break
        ;;
        3)
            install_packages "$api_files"
            break
        ;;
         r)
             echo -e "\033[31mIs not implemented yet\033[0m"
        
        ;;
         *)
            echo "Invalid input. Please enter y or n."
        ;;
    esac
done








check_server


userName=$(who | cut -d' ' -f1 | uniq)


echo 192.168.1.2:/mnt /mnt  nfs      defaults    0       2 >> /etc/fstab

sudo mount -a


ln -s /mnt/f_videos/ /home/$userName/Desktop/
