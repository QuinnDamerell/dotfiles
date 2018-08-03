echo "Getting latest configs"
cp ~/.vimrc ~/repos/dotfiles/.vimrc
cp ~/.bashrc ~/repos/dotfiles/.bashrc
cp ~/.zshrc ~/repos/dotfiles/.zshrc
cp ~/.tmux.conf ~/repos/dotfiles/.tmux.conf

echo "Commiting the files"
cd ~/repos/dotfiles/
git add -A
git commit -m "Updating the dotfiles"
git push
