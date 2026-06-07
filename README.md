# raspberry-pi-setup
my raspberry pi standard setup scritp




sudo apt update
sudo apt upgrade

to install

nvm
docker / docker compose in cli
build-essential
tldr
git
cmake
tailscale
Antigravity CLI
CodeX CLI
vim

注意tldr raspberry pi 安装

and i want some ... jump over mechanism if install faild, it will still keep installing rest softwares but
  mentioned it after all installation process finshed. 


  Prompt for adding sfotware 
    
  │ "Please add the following software to my  install.sh  script:  [insert software names here] . Use the        
  existing
  │ install_step  helper function format to ensure it tracks successes and failures. Prioritize using  sudo apt  
  │ install  if the package is available in the official Raspberry Pi/Debian repositories; otherwise, use the    
  │ official installation script wrapped in  bash -c 'set -eo pipefail; ...'  so the error tracking works        
  │ correctly."