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
# alias postgres='postgres -D /usr/local/var/postgres'

# prompt
function redhat {
PS1="[\u@\h: \W]\\$ "
PS2="> "
}
redhat

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
