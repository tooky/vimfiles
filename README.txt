Rough Installation Guide
========================

cd ~
git clone git://github.com/tooky/vimfiles.git
cd vimfiles
git submodule update --init
cd ..
ln -s vimfiles/vimrc .vimrc
ln -s vimfiles/gvimrc .gvimrc
ln -s vimfiles/vim .vim

You might also need to build the ruby extensions for command-t

cd ~/vimfiles/vim/bundle/command-t
rake make

There may be other plugins that need building.
