#--------------------------------------------------------------
# git hub commands
#--------------------------------------------------------------
# setup a new repo with git
gitnew() {
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
	git commit -m "$*"
	git push origin master
}
alias gitpush=gitpush

#--------------------------------------------------------------
# github project updates
#--------------------------------------------------------------

# push cs50 work to git
gitcs50() {
	cd ~/Dropbox/dev/school/cs50
	git add --all
	git commit -m "$*"
	git push origin master    
}
alias gitcs50=gitcs50

# push portia.co to git
gitportia.co() {
	cd ~/dev/projects/portia.co
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gitportia.co=gitportia.co

# push school folder to git
gitschool()) {
	cd ~/Dropbox/dev/school
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gitschool=gitschool
