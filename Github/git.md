#### git

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



