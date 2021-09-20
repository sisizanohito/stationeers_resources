#!/bin/bash
cd `dirname $0`

resources_ver=`cat version.txt`
locales_ver=`cat locales/version.txt`

echo "resources_ver:${resources_ver}"
echo "locales_ver:${locales_ver}"

if [[ "${resources_ver}" == "${locales_ver}" ]]; then
  echo "not update"
else
  echo "need update"
  
  echo "start update"
  martian gen -o locales
  echo "${resources_ver}" > locales/version.txt
  echo "end update"
  
  current_ver=`cat locales/version.txt`
  echo "locales_ver:${locales_ver} -> ${current_ver}"

  echo "start git"
  pushd locales
  git config user.email "sisizanohito@gmail.com"
  git config user.name "Stationeers Bot"
  git add *
  git commit -m "automated update to ${updateversion}"
  git push -f origin master
  popd
  echo "end git"
fi
