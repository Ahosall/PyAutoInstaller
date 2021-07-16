#!/bin/bash
clear
# Utils
function checkStructure() {
  echo ''
  echo '    [SYS]: Checking installer structure...'

  sleep 2

  if [ -d './files' ];
  then
    echo ''
    echo '    [SYS]: "Files" folder exists...'

    sleep 2

    echo ''
    echo '    [SYS]: Checking if the installation file exists...'

    sleep 2

    if [ -f './files/installer.tgz' ];
    then
      echo ''
      echo '    [SYS]: The file exists. Erasing to reinstall...'

      rm ./files/installer.tgz
      sleep 3
      clear
      checkStructure
    else
      echo ''
      echo '    [SYS]: File does not exist...'

      sleep 2

      if [ -d './files/installer' ];
      then
        echo ''
        echo '    [SYS]: "installer" folder exists. Erasing to reinstall...'

        sleep 3
        
        rm -Rf ./files/installer
        clear
        checkStructure
      else        
        echo ''
        echo '    [SYS]: "installer" folder does not exist...'

        sleep 4

        clear
      fi
      
    fi
  else
    echo ''
    echo '    [SYS]: "Files" folder does not exist... creating~'

    mkdir files

    sleep 2

    echo ''
    echo '    [SYS]: Restarting ...'

    sleep 1

    clear
    checkStructure
  fi
}

function banner() {
  echo ''
  echo '        ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗             '
  echo '        ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗            '
  echo '        ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝            '
  echo '        ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗            '
  echo '        ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║            '
  echo '        ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝            '
  echo '     ══════════════════════════════════════════════════════════════════════════════       '
  echo '                            ██████╗ ██╗   ██╗██████╗    █████╗                            '
  echo '                            ██╔══██╗╚██╗ ██╔╝╚════██╗  ██╔══██╗                           '
  echo '                            ██████╔╝ ╚████╔╝  █████╔╝  ╚██████║                           '
  echo '                            ██╔═══╝   ╚██╔╝   ╚═══██╗   ╚═══██║                           '
  echo '                            ██║        ██║   ██████╔╝██╗█████╔╝                           '
  echo '                            ╚═╝        ╚═╝   ╚═════╝ ╚═╝╚════╝                            '
}

function getSU() {
  sudo echo '    [SYS]: Superuser permissions were released from here...'
}

# Commands
function update() {
  echo '═══════════════════════════════════════⫸  UPDATE  ⫷═══════════════════════════════════════'
  sudo apt update -y && sudo apt upgrade -y
}

function installDependecies() {
  sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
}

function downloadFile() {
  curl -s https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz -o files/installer.tgz
  
  sleep 2
  
  echo ''
  echo '    [SYS]: File downloaded successfully...'
}

function installPy() {
  echo ''
  echo '    [SYS]: Starting preparations for installing python ...'
  
  sleep 4

  cd files/
  tar -zxf installer.tgz
  mv Python-3.9.1 installer
  
  echo ''
  echo '    [SYS]: Starting python3.9 installation ... Dont stop the script once its started!'

  sleep 4

  clear 
  banner
  echo ''
  echo '═══════════════════════════════════════⫸ INSTALL ⫷═══════════════════════════════════════'
  
  sleep 2

  ./configure --enable-optimizations
  
  clear 
  banner
  echo ''
  echo '═══════════════════════════════════════⫸ INSTALL ⫷═══════════════════════════════════════'

  make -j 2

  clear 
  banner
  echo ''
  echo '═══════════════════════════════════════⫸ INSTALL ⫷═══════════════════════════════════════'

  sudo make altinstall

  clear
  banner

  echo ''
  echo '    [SYS]: Installation was successful...'
  
  sleep 2

  echo ''
  echo '    [SYS]: Python Version:'
  echo ''
  python3.9 --verision
}

# Main
function main(){
  checkStructure
  banner
  sleep 3
  
  echo ''
  echo '    [SYS]: The script will start in a few seconds...'
  
  sleep 5
  
  echo ''
  echo '    [SYS]: Updating the system to receive python 3.9...'
  
  sleep 2
  
  echo ''
  echo '    [SYS]: Super user permissions will be used. OK? '
  
  sleep 3

  getSU
  update
  installDependecies
  downloadFile
  sleep 3
  installPy
  echo ''
  echo '    [SYS]: Check the repository for updates.'
}

main