Installation:
-------------

Enter the following commands in your home directory:

    git clone https://github.com/gyim/dotvim.git .vim
    ln -s .vim/vimrc .vimrc
    ln -s .vim/gvimrc .gvimrc
    cd .vim
    git submodule update --init

Launch vim, then enter the following command:

    :BundleInstall
