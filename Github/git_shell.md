```shell

#copy from 菜鸟教程 http://www.runoob.com/manual/git-guide/
#Easy github
#create a local repository
mkdir $filename
cd $filename
git init
#clone the repository
git clone /path/to/repository
git clone username@host:/path/to/repository

#Descirption of work flow
#working dir --add--> Index(Temporary) --commit--> Head
#add to Index
git add $filename
git add *
#submit the addition
git commit -m "Name"
#push the addition
git push origin master
#connect the remote server
git remote add origin <server>

#branch
#create a branch
git checkout -b $branch_name
#switch the master
git checkout master
#delete the branch
git branch -d $branch_name
#push the branch
git push origin $branch_name

#Update and Merge
#update your local repository
git pull
#merge the branch to master
git merge $branch_name

#if conflicts , run
git add $filename
#diff
git diff <source_branch> <target_branch>

#tag
#get the ID
git log
#tag the ID with 1.0.0
git tag 1.0.0 ID(10 or less)

#replace the wrong with head
git checkout --$filename

#
git fetch origin
git reset --hard origin/master

#Practical tips
#Xgit
gitk
#colorful git output
git config color.ui.true
#When the history is displayed, each submitted message shows only one line
git config format.pretty oneline
#interactive
git add -i


```
