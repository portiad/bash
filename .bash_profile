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
	cd /Users/portia/Google\ Drive/dev/bash
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

#
activate() {
  eval "$(dm env $@)"
}

gimp() {
	if [ $(dockerstatus gimp) -eq "0" ]
	then
		. ~/bin/gimp.sh
	else
		docker start $1
	fi
	echo "Volume located in ~/Pictures:/root/Pictures"
}

sqlitebrowser() {
	if [ $(dockerstatus sqlitebrowser) -eq "0" ]
	then
		. ~/bin/sqlitebrowser.sh
	else
		docker start $1
	fi
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
	if [ $(dm active) != "default" ]
	then
		activate default
	fi

	if [ $(docker inspect $1) != "Error: No such image or container: $1" ]
	then
		echo "0"
	else
		echo "1"
	fi
}

#------------------------------------
# ec2
#------------------------------------

# push to portia.co
alias ec2portia='scp -r -i /Users/portia/.ssh/portiaco.pem /Users/portia/Google\ Drive/dev/projects/portia.co/site/* ec2-user@ec2-54-187-75-55.us-west-2.compute.amazonaws.com:/var/www/html'
