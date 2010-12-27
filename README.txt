Installation:

    git clone git@github.com:mikem/dot-vim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

Build Command-T C Extension:

  cd ~/.vim/bundle/Command-T.git/ruby/command-t
  ruby extconf.rb
  make

Note: If you are an RVM user, you must perform the build using the same
version of Ruby that Vim itself is linked against. This will often be the
system Ruby, which can be selected before issuing the "make" command with:

  rvm use system

See the Command-T README.txt for details.
