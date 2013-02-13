# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# rake colored summery output
export FORCE_COLOR=1

# automatically enter directories without cd
setopt auto_cd

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey -M viins 'jk' vi-cmd-mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export EDITOR=vim
# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# look for ey config in project dirs
export EYRC=./.eyrc

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
NODE_PATH=/usr/local/lib/node_modules
NODE_PATH=/usr/local/lib/node_modules
<<<<<<< HEAD
=======
export PATH=/Users/pghosh/tools/apache-jmeter-2.7/bin:/usr/local/bin:/Users/pghosh/tools/play-2.0.4:$PATH
export SLI_HOME=/Users/pghosh/codebase/sli/sli
launchctl setenv PATH $PATH
export PATH=/usr/local/mysql/bin:$PATH
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
ingest-zip() {
   if [ -z $1 ] || [ -z $2 ]
   then
     echo "No zip and/or tenant specified. Usage:"
     echo "  ingest-zip <PATH_TO_ZIP> <TENANT>"
     echo "  Example tenants: Midgar-DAYBREAK, Midgar-SUNSET, Hyrule-NYC"
     return
   fi
   echo "Removing existing log files..."
   rm -rf $LZ/$2/*.log
   echo "Copying $1 to $LZ/$2/"
   cp $1 $LZ/$2/
   echo "Sleep for 2 seconds..."
   sleep 2
   zip_file=`basename $1`
   ruby $SLI_HOME/opstools/ingestion_trigger/publish_file_uploaded.rb STOR $LZ/$2/$zip_file localhost
   #poll for job log file
   echo "Polling $LZ/$2/ for job log file..."
   while [ 1 ]
   do
     job_log_file=`find $LZ/$2/ -name *.log`
     if [ ! -z $job_log_file ]
     then
       for file in $job_log_file
       do
         echo "$file found."
       done
       break
     fi
     echo -n "."
     sleep 3
   done
}
export TOGGLE_TABLESCANS=true
>>>>>>> 788d389... updated vim and other stuff
