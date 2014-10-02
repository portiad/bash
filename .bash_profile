#--------------------------------------------------------------
# git hub commands
#--------------------------------------------------------------
# setup a new repo with git
gnew() {
	git remote add origin "$*"
	git add --all
	git commit -m "intial push"
	git push origin master
}
alias gnew=gnew

# push all to git
gpushall() {
	git add --all
	git commit -m "$*"
	git push origin master
}
alias gpushall=gpushall

# push added files only to git
gpush() {
	git commit -m "$*"
	git push origin master
}
alias gpush=gpush

#--------------------------------------------------------------
# github project updates
#--------------------------------------------------------------

# push cs50 work to git
cs50() {
	cd ~/Dropbox/dev/school/cs50
	git add --all
	git commit -m "$*"
	git push origin master    
}
alias cs50=cs50

# push portia.co to git
portia.co() {
	cd ~/dev/projects/portia.co
	git add --all
	git commit -m "$*"
	git push origin master
}
alias portia.co=portia.co
