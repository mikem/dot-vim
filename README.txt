Installation:

    git clone git@github.com:mikem/dot-vim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, set up and run Vundle:

    cd ~/.vim
    git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
    vim +BundleInstall +qall
