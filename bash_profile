#--------------------------------------------------------------
# commands
#--------------------------------------------------------------

alias ll='ls -la'
alias ~='cd ~'
alias ..='cd ..'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES'
alias refresh='. ~/.bash_profile'

bashupdate() {
  cp /Users/portia/.bash_profile /Users/portia/Google\ Drive/dev/bash/
  cd /Users/portia/Google\ Drive/dev/scripts/bash
  gitaddpush "master bash updates"
  ~
}

#--------------------------------------------------------------
# common directory changes
#--------------------------------------------------------------

alias projects='cd ~/Google\ Drive/dev/projects'
alias school='cd ~/dropbox/dev/school'
alias goecho='cd ~/Google\ Drive/dev/projects/echo'
alias portia='cd ~/Google\ Drive/dev/projects/portia.co'

#--------------------------------------------------------------
# enviorment variables
#--------------------------------------------------------------

export PATH=~/bin:$PATH

#--------------------------------------------------------------
# git commands
#--------------------------------------------------------------

# setup a new repo with git
gitnew() {
  git init
  git remote add origin "$*"
  git add --all
  git commit -m "intial push"
  git push origin master
}

# push add and push all files to git
# first param is the branch to push to
gitaddpush() {
  git add --all
  gitpush $*
}

# push exisiting files only to git
# first param is the branch to push to
gitpush() {
  if [[ $( git branch --list "$1" ) ]]
  then
    value=$(echo "${@:2}")
    git commit -am "$value"
    git push origin "$1"
  else
    echo "Enter in a valid branch"
  fi
}

gitbranch() {
  git checkout -b "$1"
  git push origin "$1"
}

#--------------------------------------------------------------
# docker commands
#--------------------------------------------------------------

# start default docker machine
alias dmd='dm create -d virtualbox default'

# docker machine
alias dm=docker-machine

# docker swarm
alias ds=docker-swarm

# docker compose
alias dkc=docker-compose

# clean up docker
dockercleanup() {
  docker rm -vf $(docker ps -aq)
  docker rmi -f $(docker images -q)
}


#
activate() {
  dm start $@
  eval "$(dm env $@)"
  echo "$@ active"
}

gimp() {
  dockerstatus
  . ~/bin/gimp.sh
  echo "Volume located in ~/Pictures:/root/Pictures"
}

sqlitebrowser() {
  dockerstatus
  . ~/bin/sqlitebrowser.sh
  echo "Volume located in "$(pwd)"/sqlite:/root/sqlite"
}

# npm
npm() {
  docker run -it --rm -v "$(pwd)":/work -w /work node:latest npm $@
}

# node
node() {
  docker run -it --rm -v "$(pwd)":/work -w /work node:latest node $@
}

# redis cli
redis-cli() {
  sid=`docker run -d redis:latest redis-server $@`
  docker run -it --rm --link $sid:server redis:latest redis-cli -h server 
  docker rm -vf $sid
}

dockerstatus() {
  if [ "$(dm active)" != "default" ]
  then
    activate default
  fi
}

dgo() {
  docker run --rm \
  -v "$GOPATH":/go \
  -w /go/${PWD#$GOPATH} \
  -e GOOS=darwin \
  -e GOARCH=amd64 \
  golang:1.8 go $@
}

#-----------------------------------
# builder tools
#-----------------------------------

# port forwarding to access rancher
bt-forward() {
  ssh -i ~/.ssh/bastion1.pem -L 9000:internal-DevOps-RancherLoad-NI6A7B07H3M0-554951381.us-west-2.elb.amazonaws.com:80 ec2-user@35.162.206.219
}


#------------------------------------
# ec2
#------------------------------------

# push to portia.co
alias ec2portia='scp -r -i /Users/portia/.ssh/portiaco.pem /Users/portia/Google\ Drive/dev/projects/portia.co/site/* ec2-user@ec2-54-187-75-55.us-west-2.compute.amazonaws.com:/var/www/html'
