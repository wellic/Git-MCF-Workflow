Workflow
========

Attention!!!
Before use this file? replace in .gitconfig 'wellic' on 'your_username'

default branches
----------------

masterNameBranch = master 
cfgNameBranch    = cfg 
fixNameBranch    = fix

Tasks
-----

1) Create new branch for work and fix bug on branch 'newfix'
  a) 
    git co cfg
    git co -b newfix
  b) 
    ... edit files ...
    git st 
    git add ...
    git ci -m 'your message'
  c) 
    git upload newfix

2) Change local configs
  a) 
     git co cfg
  b) 
     ... edit and setup files ...
     git st 
     git add .
     git ci -m 'your message'
  c) 
  git rb cfg fix

3) Fix bug or make feautures on branch 'fix':
  a) 
    git co fix
  b) 
    ... edit files ...
    git st 
    git add .
    git ci -m 'your message'
  c) 
    git upload 

4) Load local fixed sources to master 
    git load
    git load fixNameBranch
    git load fixNameBranch cfgNameBranch
    git load fixNameBranch cfgNameBranch masterNameBranc

5) Load local fixed sources to master and push three branches to repo
    git upload
    git upload fixNameBranch
    git upload fixNameBranch cfgNameBranch
    git upload fixNameBranch cfgNameBranch masterNameBranc

6) Pull new sources from git repo and update branches
    git update 
    git update fixNameBranch
    git update fixNameBranch cfgNameBranch
    git update fixNameBranch cfgNameBranch masterNameBranc

