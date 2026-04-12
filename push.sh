#!/bin/bash
set -e

GIT_SSH_COMMAND="ssh -i ~/.ssh/github1 -o IdentitiesOnly=yes" git add -A
GIT_SSH_COMMAND="ssh -i ~/.ssh/github1 -o IdentitiesOnly=yes" git commit -m "${1:-update}"
GIT_SSH_COMMAND="ssh -i ~/.ssh/github1 -o IdentitiesOnly=yes" git push
