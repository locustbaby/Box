```shell
#!/bin/bash

#Ubuntu + Hexo + github by locustbaby

#Nodejs' install
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

#npm's install
sudo apt-get install npm

#git's install 
sudo apt-get install git

#git-ssh config
git config --global user.name "locustbaby"
git config --global user.email "1415182877@qq.com"

ssh-keygen -t rsa -C "1415182877@qq.com"
#ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

#cp the id_rsa.pub to github

#test ssh to git
ssh -T git@github.com
#type the yes

#git config & test
touch README.md
git init
git remote add origin git@github.com:locustbaby/locustbaby.github.io.git
#vi .git/config
#[remote "origin"]
#    url = git@github.com:locustbaby/locustbaby.github.io.git
#    fetch = +refs/heads/*:refs/remotes/origin/*
git add README.md
git commit -m "First commit to test ssh"
git push -u origin master

#git branch 
git branch hexo
git checkout hexo
git push origin hexo

#default the hexo

#Hexo's install
sudo npm install -g hexo-cli

#hexo-deployer-git
npm install hexo-deployer-git --save

#Hexo init
hexo init locustbaby
cd locustbaby
npm install

vi _config.yml
	deploy:
		type: git
		repo: git@github.com:username/username.github.io.git
		branch: master
#static
hexo g 
#localhost test
hexo s
#deploy
hexo d

#hexo backup
git clone https://github.com/locustbaby/locustbaby.github.io.git
git add --all
git commit -m "blog souce commit"
git push origin hexo

# 依次执行git add .、git commit -m "..."、git push origin hexo指令将改动推送到GitHub（此时当前分支应为hexo）；然后再执行hexo g -d发布网站到master分支上。




```

