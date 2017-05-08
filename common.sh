#!/bin/bash -e

print_header1() {
    msg=$1

    echo -e "\n\n"
    echo "#####################################################################"
    echo "# ${msg}"
    echo "#####################################################################"
}

print_header2() {
    msg=$1

    echo -e "\n\n"
    echo "-------------------------------------------------------"
    echo "${msg}"
    echo "======================================================="
}

get_repository_key() {
  current_branch=`git rev-parse --abbrev-ref HEAD`

  if [[ "${current_branch}" =~ "release" ]]; then
    repository_key="packages-staging"
  elif [[ "${current_branch}" =~ "master" ]]; then
    repository_key="packages-prod"
  else
    repository_key="packages-dev"
  fi

  echo ${repository_key}
}
