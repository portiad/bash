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
	cp /Users/portia/.bash_profile /Users/portia/dev/bash/
	cd /Users/portia/dev/bash
	gitpushall "bash updates"
	~
}
alias bashupdate=bashupdate

#--------------------------------------------------------------
# common directory changes
#--------------------------------------------------------------

alias projects='cd ~/dev/projects'
alias school='cd ~/dropbox/dev/school'
alias goecho='cd ~/dev/projects/echo'
alias portia='cd ~/dev/projects/portia.co'

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
alias gitnew=gitnew

# push all to git
gitpushall() {
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gitpushall=gitpushall

# push added files only to git
gitpush() {
	git commit -am "$*"
	git push origin master
}
alias gitpush=gitpush

#--------------------------------------------------------------
# docker commands
#--------------------------------------------------------------

# start docker
letsdocker() {
	boot2docker up
	$(boot2docker shellinit)
}
alias letsdocker=letsdocker

#--------------------------------------------------------------
# project specific commands
#--------------------------------------------------------------

#------------------------------------
# portia.co
#------------------------------------

# push to ec2
alias ec2portia='scp -r -i /Users/portia/.ssh/portiaco.pem /Users/portia/dev/projects/portia.co/site/* ec2-user@ec2-54-187-75-55.us-west-2.compute.amazonaws.com:/var/www/html'

# push to git hub
gitportia.co() {
	cd ~/dev/projects/portia.co
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gitportia.co=gitportia.co

#------------------------------------
# school
#------------------------------------

# push school folder to git
gitschool() {
	cd ~/Dropbox/dev/school
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gitschool=gitschool