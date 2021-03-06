echo "Hey there! Let's get set up!" && \
sudo echo > /dev/null && \
\
sudo rm -rf ~/.DebianCfg ~/.vimrc ~/.tmux.conf ~/.zshenv ~/.vim && \  
mkdir -p ~/.vim/bundle/ && \
\
echo && \
echo "Cloning Vundle..." && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
\
echo && \
echo "Installing packages from apt-get..." && \
sudo apt-get update -y && \
sudo apt-get upgrade -y && \
sudo apt-get install -y tmux zsh python python3 python-pip python3-pip wget && \
\
echo && \
echo "Installing Python packages..." && \
sudo -H pip3 install ansicolor google-api-python-client && \
\
echo && \
echo "Installing oh-my-zsh..." && \
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && \
\
echo && \
echo "Symlinking files and directories..." && \
\
\# Files
ln -s $PWD/zshenv ~/.zshenv && \
ln -s $PWD/vimrc ~/.vimrc && \
ln -s $PWD/tmux.conf ~/.tmux.conf && \
\
\# Dirs
ln -s $PWD/config ~/.DebianCfg && \
\
echo && \
echo "Installing Vim plugins..." && \
vim +PluginInstall +qall && \
\
echo && \
echo "All done!"
