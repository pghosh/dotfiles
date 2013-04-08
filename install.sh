#!/bin/sh
setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" git/gitconfig.symlink.example > git/gitconfig.symlink

    success 'gitconfig'
  fi
}
install_dotfiles() {
  for name in *; do
    target="$HOME/.$name"
    if [ -e "$target" ]; then
      if [ ! -L "$target" ]; then
        cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
        if [ -n "$cutline" ]; then
          cutline=$((cutline-1))
          echo "Updating $target"
          head -n $cutline "$target" > update_tmp
          startline=`sed '1!G;h;$!d' "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
          if [ -n "$startline" ]; then
            tail -n $startline "$name" >> update_tmp
          else
            cat "$name" >> update_tmp
          fi
          mv update_tmp "$target"
        else
          echo "WARNING: $target exists but is not a symlink."
        fi
      fi
    else
      if [ "$name" != 'install.sh' ]; then
        echo "Creating $target"
        if [ -n "$(grep "$cutstring" "$name")" ]; then
          cp "$PWD/$name" "$target"
        else
          ln -s "$PWD/$name" "$target"
        fi
      fi
    fi
  done
}
setup_vim(){
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim +BundleInstall +qall
}
setup_ruby(){
  curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled
}
setup_homebrew(){
  if test ! $(which brew)
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  then
  fi
  # Make sure we’re using the latest Homebrew
  brew update

  # Upgrade any already-installed formulae
  brew upgrade

  # Install GNU core utilities (those that come with OS X are outdated)
  brew install coreutils
  # Install wget with IRI support
  brew install wget --enable-iri
  brew install reattach-to-user-namespace
  brew install the_sliver_searcher
  brew install macvim --override-system-vim
}
setup_gitconfig
install_dotfiles
setup_ruby
setup_homebrew
setup_vim


