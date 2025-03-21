#!/bin/bash

sudo apt update
sudo apt install file -y

repo_name=$1
repo_uri=$2
key_uri=$3
suite=$4
# Remove the previous 4 arguments from argument array
shift;
shift;
shift;
shift;
# read the last arguments to components variable
components="$@"

wget -q -O key.gpg $key_uri
typecount=$(file key.gpg | grep -c "PGP public key block Public-Key")
if [[ $typecount > 0 ]]
then
  gpg --no-default-keyring --keyring ./tmp.gpg --import key.gpg
  gpg --no-default-keyring --keyring ./tmp.gpg --export --output $repo_name.gpg
  rm tmp.gpg
  sudo mv $repo_name.gpg /etc/apt/keyrings/$repo_name.gpg
else
  sudo mv key.gpg /etc/apt/keyrings/$repo_name.gpg
fi
rm key.gpg

#  Write sources list file in DEB822 format
# 
echo "Types: deb deb-src" | sudo tee /etc/apt/sources.list.d/$repo_name.sources
echo "URIs: $repo_uri" | sudo tee -a /etc/apt/sources.list.d/$repo_name.sources
echo "Suites: $suite" | sudo tee -a /etc/apt/sources.list.d/$repo_name.sources
if [[ "$components" == "" ]]; then
  echo ""
else
  echo "Components: $components" | sudo tee -a /etc/apt/sources.list.d/$repo_name.sources
fi
echo "Signed-By: /etc/apt/keyrings/$repo_name.gpg" | sudo tee -a /etc/apt/sources.list.d/$repo_name.sources
sudo apt update
