#!/usr/bin/env bash

set -eu

echo "---> Set up .gitconfig.local ..."

if [ ! -f ~/.gitconfig.local ]; then
  read -p "Please input your email: " -r email
  read -p "Please input your name: " -r name
  
  config="[user]
  \temail = $email
  \tname  = $name"

  echo -e "$config" > ~/.gitconfig.local
  echo "Successfully generated \"~/.gitconfig.local\"!"
else
  echo "Skip this process because \"~/.gitconfig.local\" is already exist"
fi

