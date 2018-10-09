
check_for_err() {
   retVal=$?
   if [ $retVal -ne 0 ]; then
        echo "Failed to $1"
        exit 1
   else
        echo "Success - $1"
   fi
}

install_program () {
   if hash $1 2>/dev/null; then
        echo "$1 is already installed"
	return 1
   fi

   if hash apt 2>/dev/null; then
        sudo apt-get install $1 -y 1>/dev/null
   else
        sudo yum install $1 -y
   fi

   check_for_err "Installing $1"
   return 0
}

install_omzsh() { 
   install_program "zsh"   
   rm -fdr ~/.oh-my-zsh/
   check_for_err "Removing zsh repo"
   git clone --quiet https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh >/dev/null   
   check_for_err "Cloning omzsh"
  
   TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
   if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then   
      chsh -s /bin/zsh
      check_for_err "Setting zsh as default" 
   fi
}

setup_vim() {
  # Clone the colors repo
  rm -fdr ~/.vim-colors-solarized
  git clone --quiet https://github.com/altercation/vim-colors-solarized.git ~/.vim-colors-solarized >/dev/null
  check_for_err "Cloning solarized repo"
  mkdir -p ~/.vim/colors
  check_for_err "Making the vim folders"
  mv ~/.vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
  check_for_err "Copying the vim color config"
  cp ./.vimrc ~/.vimrc
  echo "vim setup complete"
}

setup_git() {
   git config --global push.default simple
   git config --global user.name "Quinn Damerell"   
   echo " "
   echo "Is this a personal or work setup? (p or w}"
   read answer
   if [ "$answer" = "p" ]; then
       echo "Setting up personal git"
       git config --global user.email quinnd@outlook.com
   else 
       echo "Setting git for work..."
       git config --global user.email qdamere@microsoft.com
   fi
}

echo " "
echo " "
echo "********************"
echo "  Q Setup Script!"
echo "********************"
setup_git;
chmod +x ./update.sh
chmod +x ./write.sh


echo " "
echo " "
echo "********************"
echo "    Installing"
echo "********************"

install_omzsh;
install_program "tmux";

echo " "
echo " "
echo "********************"
echo "    Copy Configs"
echo "********************"

cp ./.tmux.conf ~/.tmux.conf
cp ./.zshrc ~/.zshrc
cp ./.bashrc ~/.bashrc
cp ./ssh_config ~/.ssh/config
setup_vim;


echo " "
echo "************************"
echo " Done! Starting zsh..."
echo "************************"

zsh -l
