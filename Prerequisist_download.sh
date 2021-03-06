#!/bin/bash

# Kubectl —  https://kubernetes.io/docs/tasks/tools/install-kubectl/
REQUIRED_PKG="kubectl"
PKG_OK=$(command -v $REQUIRED_PKG)
echo Checking for $REQUIRED_PKG: $PKG_OK package is present
if [ "" = "$PKG_OK" ]; then
    echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    kubectl --version
    echo "Kubectl successfuly installed."
fi

#AWS CLI -  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
REQUIRED_PKG="aws"
PKG_OK=$(command -v $REQUIRED_PKG)
echo Checking for $REQUIRED_PKG: $PKG_OK package is present
if [ "" = "$PKG_OK" ]; then
    echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    aws --version
    echo "aws cli successfuly installed."
fi


#Aws iam authenticator — https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
REQUIRED_PKG="aws-iam-authenticator"
PKG_OK=$(command -v $REQUIRED_PKG)
echo Checking for $REQUIRED_PKG: $PKG_OK package is present
if [ "" = "$PKG_OK" ]; then
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator
  mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
  echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
  aws-iam-authenticator version
  echo "aws-iam-authenticator successfuly installed."
fi


#eksctl — https://github.com/weaveworks/eksctl
REQUIRED_PKG="eksctl"
PKG_OK=$(command -v $REQUIRED_PKG)
echo Checking for $REQUIRED_PKG: $PKG_OK package is present
if [ "" = "$PKG_OK" ]; then
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
  eksctl version
  echo "eksctl successfuly installed."
fi


rm -rf awscliv2.zip

rm -rf aws-iam-authenticator

rm -rf aws
