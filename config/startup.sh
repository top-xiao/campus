#!/bin/sh

sudo apt update && sudo apt -y install texlive qpdfview git ssh curl neovim x11-apps x-11-utils x11-xserver-utils dbus-x11 gnuplot gcc g++

echo "Set your github username:"
read username
git config --global user.name $username

echo "Set your github email:"
read useremail
git config --global user.email $useremail

echo "これから ssh-rsa から .comまでの内容をコピーして, github の設定ー> ssh-keyに追加してください"
echo "yes の入力を求める場合はyesを入力し, 他の設定は無視してEnter keyを押して飛ばす"
ssh-keygen -t rsa -C $useremail
cat ~/.ssh/id_rsa.pub
echo "設定完了したらEnter keyを押してください, 他の設定は無視してEnter keyを押して飛ばす"

read junk
echo "次にyes の入力を求める場合はyesを入力し, 他の設定は無視してEnter keyを押して飛ばす"
ssh -T git@github.com

echo "repository download"
mkdir ~/Documents/
cd ~/Documents
git clone https://github.com/top-xiao/campus.git
cp -r /campus/.config/ ~/.config
cd ~

sudo add-apt-repository ppa:neovim-ppa/stable
echo  "#nvim" | cat >> ~/.bashrc
echo  "alias vim = 'nvim'" | cat >> ~/.bashrc
echo  "alias vi = 'nvim'" | cat >> ~/.bashrc
echo  "alias v = 'nvim'" | cat >> ~/.bashrc
echo -e "\n" | cat >> ~/.bashrc
echo  "#nvim_environment_variable" | cat >> ~/.bashrc
echo "export NVIM_LISTEN_ADDRESS = /tmp/nvimsocket" | cat >> ~/.bashrc 

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

vim -E -c :PackerSync -c q
