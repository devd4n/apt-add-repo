# apt-add-repo
the apt-add-repo script replaces the command "add-apt-repository" on debian Systems.

### Steps to install
1. download this script to the bin folder \ 
   ```sudo wget -qO /usr/bin/apt-add-repo https://raw.githubusercontent.com/devd4n/apt-add-repo/main/apt-add-repo.sh```
2. make it executable \
   ```sudo chmod +x /usr/bin/apt-add-repo```

## Usage
```sudo apt-add-repo <<repo_name>> <<repo_uri>> <<key_uri>> <<suite>>> <<component>> <<component>>```

## Usage-Examples
```
apt-add-repo sublime-text https://download.sublimetext.com/ https://download.sublimetext.com/sublimehq-pub.gpg apt/stable/
apt-add-repo signal-desktop https://updates.signal.org/desktop/apt/keys.asc https://updates.signal.org/desktop/apt xenial main

```

## What it does and How?
command adds key to apt gpg keyring (/etc/apt/keyrings/$repo_name.gpg) \
and also creates a new sources file in "/etc/apt/sources.list.d/" <<repo_name>>.sources with the following Content:

```
Types: deb deb-src
URIs: <<repo_uri>>
Suites: <<suite>>
Components: <<components>>
Signed-By: /etc/apt/keyrings/<<repo_name>>.gpg
```

Update Package Repo Data \
```sudo apt update```

