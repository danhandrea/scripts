#!/bin/bash
clear
echo "Hi, $USER!"
nvm_installed=false
node_installed=true

if [ $(ls ~/ -a | grep .nvm2) ]
  then
    nvm_installed=true
fi

node_version=$(node -v) || node_installed=false

if [ $nvm_installed ]
  then
    echo "nvm installed!"
    if [ $node_installed ]
      then
        echo "node $node_version installed"
        major=${node_version:1:1}
        minor=${node_version:3:1}
        if (( $major < 6 ))
          then
            echo "need to update node version"
            update_node=1
          else
            if (( $minor < 7 ))
              then
                echo "need to update node version"
                update_node=1
            fi
        fi
        if [ $update_node ]
          then
            echo "installing newer version of node"
            nvm install 6.7.0 && nvm use 6.7.0 || echo "failed to install node"
        fi
        echo "nothing to do, exiting"
      else
        echo "node not installed"
        echo "installing node"
        nvm install 6.7.0 && nvm use 6.7.0 || echo "failed to install node"
    fi
  else
    echo "nvm not installed"
    if [ $node_installed ]
      then
        echo "node installed"
        echo "no need for nvm exiting"
      else
        echo "nvm not installed!"
        echo "Installing nvm"
        wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
        export NVM_DIR="/home/pi/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        echo "installing node"
        nvm install 6.7.0 && nvm use 6.7.0 || echo "failed to install node"
    fi
fi
