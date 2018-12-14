pathadd ()
# http://snippets.dzone.com/posts/show/4821
{
    _folder=$1
    echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
    [ $? -ne 0 ] && [ -d $_folder ] && PATH=$PATH:$_folder
    export PATH
}

# alias
alias ls='ls -hFG'  # add colors for filetype recognition
alias vi='vim'
alias lt='ls -ltrh'
alias review='review -a r-and-l-engagement -c rl-engagement-eng'
# alias postgres='postgres -D /usr/local/var/postgres'
alias web='cd $HOME/development/Etsyweb'
alias in='$HOME/development/bin/.in'
# prompt
# function redhat {
# PS1="[\u@\h: \W]\\$ "
# PS2="> "
# }
# redhat

# bash_prompt

# yanked from:
# https://github.com/necolas/dotfiles/blob/master/shell/bash_prompt

# Example:
# nicolas@host: ~/.dotfiles on master [+!?$]
# $

# Screenshot: http://i.imgur.com/DSJ1G.png
# iTerm2 prefs: import Solarized theme (disable bright colors for bold text)
# Color ref: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
# More tips: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

set_prompts() {
    local black=""
    local blue=""
    local bold=""
    local cyan=""
    local green=""
    local orange=""
    local purple=""
    local red=""
    local reset=""
    local white=""
    local yellow=""

    local hostStyle=""
    local userStyle=""

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        tput sgr0 # reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        bold=""
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"
    fi

    # build the prompt

    # logged in as root
    if [[ "$USER" == "root" ]]; then
        userStyle="\[$bold$red\]"
    else
        userStyle="\[$orange\]"
    fi

    # connected via ssh
    if [[ "$SSH_TTY" ]]; then
        hostStyle="\[$bold$red\]"
    else
        hostStyle="\[$yellow\]"
    fi

    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    PS1+="\n" # newline
    PS1+="\[$userStyle\]\u" # username
    PS1+="\[$reset$white\]@"
    PS1+="\[$hostStyle\]\h" # host
    PS1+="\[$reset$white\]: "
    PS1+="\[$green\]\w" # working directory
    PS1+="\n"
    PS1+="\[$reset$white\]\$ \[$reset\]" # $ (and reset color)

    export PS1
}

set_prompts
unset set_prompts

# path
export PATH=~/bin:/usr/local/bin:$PATH
# pathadd /usr/local/share/npm/bin
# pathadd /usr/local/share/python

# enable terminal colors
# http://noiseandheat.com/blog/2011/12/os-x-lion-terminal-colours/
export CLICOLOR=1
# https://github.com/seebi/dircolors-solarized/issues/10
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
# export LSCOLORS=Exfxcxdxbxegedabagacad
# use x11 as the default Gnuplot terminal:
# http://www.miscdebris.net/blog/2009/09/16/install-gnuplot-on-mac-os-x/
export GNUTERM=x11

export EDITOR=vim

# java classpath
# export CLASSPATH=$CLASSPATH:$HOME/Dropbox/coursera/algorithms/lib/*:.

# java home
# http://stackoverflow.com/questions/6588390/where-is-java-home-on-osx-lion-10-7-mountain-lion-10-8-or-mavericks-10-9
# export JAVA_HOME=`/usr/libexec/java_home -v 1.6`

# hadoop configs
# export HADOOP_HOME=$HOME/Library/Hadoop
# export HBASE_HOME=$HOME/Library/HBase

# pathadd $HADOOP_HOME/bin
# pathadd $HBASE_HOME/bin

# pathadd $HOME/.rvm/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#

eval $(~/development/bin/dbaliases)


commits_per_week() {
    git log --author="$1" --date=iso | grep Date | awk '{print $2}' | \
        xargs -I {} date --date={} +%Y-%W | sort -nr | uniq -c
}

pr_comments_per_week() {
    curl -s \
    'https://github.etsycorp.com/api/v3/search/issues?q=+type:pr+commenter:pjletourneau&sort=created&order=desc' \
    | jq '.items | .[] | select(.user.login != "pjletourneau") | .created_at' | \
        xargs -I {} date --date={} +%Y-%W | uniq -c
}


function syncweb(){
    #ssh_client="pjletourneau.prodvpn.etsy.com"
    #ssh_client=$(echo $SSH_CLIENT | awk '{print $1}')
    ssh_client="10.200.100.71"
    echo "syncing etsyweb on vm to $USER on $ssh_client ..."
    rsync -mravz --delete \
        --exclude=".idea" --exclude=".git" --exclude=".phan" --exclude="*assets/dist*" \
        --exclude="tmp" --exclude="translations" \
        --include="*.php" --include="*.js" --include="*.scss" --include="*.css" \
        --include="*.tpl" --include="*.mustache" --include=".htaccess" \
        --include="*.jsx" \
        --include="composer.*" \
        --include="*/" \
        --exclude="*" \
        -e ssh /home/$USER/development/Etsyweb \
        "$USER@$ssh_client":/Users/$USER/development
}

export -f syncweb

function branch_pick() {
    # TODO: get branch from github api call
    branch="$1"
    git co master
    sha=$(git log | head -1 | awk '{print $2}')
    echo "[branch_pick] sha for most recent commit on master: $sha"
    echo "[branch_pick] switching to branch $branch"
    git co $branch
    echo "[branch_pick] cherry-picking commit from master to $branch ..."
    git cherry-pick $sha --strategy-option=theirs
    git st
    echo "[branch_pick] pushing commit to $branch"
    git push
    echo "[branch_pick] checking out master ..."
    git co master
    git st
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
