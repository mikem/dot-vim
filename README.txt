Installation:

    git clone git@github.com:mikem/dot-vim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

Build the VimClojure nailgun client:

    cd ~/.vim/bundle/vimclojure-nailgun-client
    make

Adding New Submodules:

  cd ~/.vim
  git submodule add <path-to-repo> bundle/<bundle-name>.git
