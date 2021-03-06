#### [git](https://www.liaoxuefeng.com/wiki/896043488029600)

```shell
git status
git diff $file
git log --pretty=oneline
git reset --hard 1094a
git reflog

git checkout -- $file 	#回到最近一次修改的状态
git rm 
#	分支
git checkout <name>	#切换分支
git checkout -b <name> 	#创建并切换
git merge dev	#合并指定分支到当前分支
git branch -d <name>	#删除分支
git branch	#查看分支
git branch <name>	#创建分支
git log --graph --pretty=oneline --abbrev-commit	#
git merge --no-ff -m "merge with no-ff" dev
git log --graph --pretty=oneline --abbrev-commit
#	合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并
git stash	#储藏
git stash list

#	修复master bug
git checkout
git checkout -b issue-101
git add $file
git commit -m "fix bug 101"
git checkout master
git merge --no-ff -m "merged bug fix 101" issue-101
#	切回stash
git checkout dev
git status
git stash list
#	恢复并删除stash
1:	git stash apply
	git stash drop
2:	git stash pop

git stash apply stash@{0}

#	Feature分支
git branch -D feature-vulcan	#强行删除分支
```

> 常用

```shell
git remote -v
git remote add $gitname
git fetch $gitname
git push $gitname

git checkout -b dev
git checkout master #change

git add 
git commit
git push

git clone git@github.com:locustbaby/Box.git #or HTTPS

git pull

git config credential.helper 'store [<options>]'
# 用户名密码保存于	~/.git-credentials
```



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