#!/bin/bash -eu
#############################################
# gitconfig を一時的に Git 管理から外します #
#############################################

cd "$(dirname "$0")/../.."

if git ls-files -v | grep ^H | grep gitconfig &> /dev/null; then
  git update-index --skip-worktree gitconfig
  echo "Successfully removed from Git control now!"
else
  git update-index --no-skip-worktree gitconfig
  echo "Successfully added from Git controle now!"
fi

