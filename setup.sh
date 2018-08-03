
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
   if hash apt 2>/dev/null; then
        sudo apt-get install $1 -y 1>/dev/null
   else
        sudo yum install $1 -y
   fi

   check_for_err "Installing $1"
}

install_omzsh() { 
   install_program "zsh"
   rm -fdr ~/.oh-my-zsh/
   check_for_err "Removing zsh repo"
   git clone --quiet https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh >/dev/null   
   check_for_err "Cloning omzsh"
   chsh -s /bin/zsh
   check_for_err "Setting zsh as default" 
}

setup_git() {
   echo " "
   echo "Is this a personal or work setup? (p or w}"
   read answer
   #if [ "$answer" == "p" ]; then
   #    echo "Setting up personal git"
   #    git config --global user.name "Quinn Damerell"
   #    git config --global user.email quinnd@outlook.com
   #else 
       echo "Setting up work git"
       git config --global user.name "Quinn Damerell"
       git config --global user.email qdamere@microsoft.com
   #fi
}

echo "********************"
echo "  Q Setup Script!"
echo "********************"
setup_git;

echo "********************"
echo "    Installing"
echo "********************"

install_omzsh;
install_program "tmux";

echo "********************"
echo "    Copy Configs"
echo "********************"

cp ./.tmux.conf ~/.tmux.conf
cp ./.zshrc ~/.zshrc




echo "Starting zsh!"
zsh -l
