#
# Incorporates my old .zshrc functions and aliases.
#
# Author:
#   Addison White <he.himself@addisonpwhite.com>
#

# RiotGames API Key
export RIOT_KEY=2ca5a294-c8f1-475b-9595-58ccf30a9e63

### Adding Twilio API Key
export TWILIO_ACCOUNT_SID="ACceba19a36b794a6cbbfc74654fc3d348"
export TWILIO_AUTH_TOKEN="b021a8c0bb1e46a5ea90c4b99fb5186c"


# turn hidden files on/off in Finder
function hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }

# postgres functions
function psqlstart() { /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start ; }
function psqlstop() { /usr/local/pgsql/bin/pg_ctl stop ; }

# view man pages in Preview
function pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

# apache tomcat functions
function tomcatup() { /usr/local/tomcat/bin/startup.sh ; }
function tomcatdown() { /usr/local/tomcat/bin/shutdown.sh ; }

# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
# displays mounted drive information in a nicely formatted manner
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

# myIP address
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

function newip() {
}

# myExtIP address
function myextip() {
	curl -s ipinfo.io | grep ip | awk '{ print $2 }' | sed s/\"//g | sed s/,//g
}

# Create workspace and cd to it
function mkws() {
    mkdir -p ~/Desktop/WSHOME/WS$(date "+%m%d%Y") && cd ~/Desktop/WSHOME/WS$(date "+%m%d%Y")
}
export PWS=$HOME/Desktop/WSHOME/WS$(date "+%m%d%Y") 

# ping left cart hosts
function pingcart() {
    for i in {201,202,203,204,209,210,211,212,217,218,219,220};
    do
        echo "HOSTGROUP: $i";
        for j in {0..3};
        do
            ping -oc 2 -t 2 bats-e-$1-$i-$j.apple.com > /dev/null && echo "bats-e-$1-$i-$j -- alive" || echo "bats-e-$1-$i-$j -- DEAD------DEAD";
        done;
    done
}

# Parse out bats-e-* hostnames
function cartgrep() {
    egrep -o "bats-e-([0-9]*)-([0-9]*)-[0-4]"
}

#
## new functions
#
s() { pwd >! ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }

# post to pastebin
haste() { a=$(cat); curl -X POST -s -d "$a" https://hastebin.com/documents | awk -F '"' '{print "http://hastebin.com/"$4}'; }
phaste() { a=$(cat); curl -X POST -s -d "$a" http://hastebin.com/documents | awk -F '"' '{print "http://hastebin.com/"$4}'; }

# Identify hardware codename
alias hwid='/usr/local/bin/ypc2 -k RPlt | xxd -r -p && printf "\n"'

## Aliases
alias mou='open -a MacDown.app' #mou opens files in Mou.app
alias safari='open -a Safari.app' #Safari opens files in Safari.app
alias cdelim='tr -s " " | cut -d " " -f 2 | tr "\n" "," | sed "s/,$//"'

## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
## Added by chef opscode.com
export PATH="/opt/chef/embedded/bin:$PATH"
## Added by Android SDK
export PATH="/Users/addisonwhite/Code/lib/adt-bundle-mac-x86_64-20130219/sdk/platform-tools:$PATH"
## Added path for macports
export PATH="/opt/local/bin:$PATH"
## Trying to fix homebrew path
export PATH="/usr/local/bin:$PATH"
## Adding redis
export PATH="/usr/local/redis-stable/src:$PATH"
eval `perl -I ~/Library/perl5/lib/perl5 -Mlocal::lib=~/Library/perl5`
## Addison GOPATH and go bin
export GOPATH="/Volumes/Data/Users/addisonwhite/src/golang"
export PATH="$GOPATH/bin:$PATH"
# BATS Exports
export BATS_USERNAME="addison_white"
export BATS_RADAR_REQUIRED=0
# Setup Conda exports
# export PATH="/Volumes/Data/Users/addisonwhite/anaconda/bin:$PATH"
# Add ~/bin to PATH
export PATH="/Volumes/Data/Users/addisonwhite/bin:$PATH"
# Nirdroot Key
export NIRDROOT_KEY="f0217023c0104235b342346ecd594667"
export GOVAIN_TOKEN="f9ec-efcb-11eb"
export PROJECT_HOME="$HOME/src"
# if [[ "$(ls ~addison_white/bin | wc -l)" -gt 10 ]]
# then
#     export PATH="$PATH:/Network/Servers/nwna40a.apple.com/vol/homedir3/addison_white/bin"
# fi
