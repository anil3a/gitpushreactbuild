#!/bin/sh
#title           :AnilPrz's Life with GIT & REACT
#description     :This script helps to do everyday / every 3/4 hour git push or npm run build or git pull
#author          :Anil Prajapati
#date            :20181012
#version         :1
#usage           :bash gitpush.sh /home/anil/myrepo/ MyBranchName MyReactFolder
#notes           :This is a personal script to make my life easier. It works for any GIT repo with REACT folder just inside the GIT repo. You can Skip react if you dont have
#bash_version    :4.1.5
#==============================================================================

# Pretty spacing in Start
echo " "

if [ $# != 3 ]; then
    echo "You need to supply 3 arguments. They are "
    echo "    1st = path to the repository ( only absolute )"
    echo "    2nd = git branch name "
    echo "    3rd = folder name for react part "
    echo  " " && exit 0
fi

# Project Folder
cd $1

# Verify if branch exist in your git repository
exists=`git show-ref refs/heads/$2`
if [ -z "$exists" ]; then
    echo "Branch $2 does not exist" 
    echo " " && exit 0;
fi

# Looks better with this
echo "Running your favourite script.........."
sleep 1

# Loop script so i can run again if i miss any command or if i want to run one command and run again from top
runagain=y

# loop
while [ "$runagain" = y ]
do

  echo 
  echo "Started ....."
  sleep 1

  # Go to Project again Reseting the WHILE LOOP path
  cd $1
  echo "PWD -- First Argument"
  pwd

  # Spacing for prettier
  echo 
  echo 

  # Commit all your changes in your local first before it gets lost
  read -p "Do you want to ADD and COMMIT MESSAGe ?  { Y / N / } " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo 
    echo "GIT ADD ."
    git add .
    git status

    # Easy commit message submission for your GIT COMMIT
    read -p "Please enter your commit message? " msg
    if [[ -z "$msg" ]]; then
       printf '%s\n' "No commit message entered"
       exit 1
    fi

    echo 
    echo "GIT COMMIT -M  -- Forth Argument"
    git commit -m "$msg"
    git status

  fi

  # Getting pretty with space
  echo 
  echo 

  # Do GIT PULL your branch to update your local HEAD and see GIT STATUS before push for conflicts or anything
  read -p "Do you want to PULL ?  { Y / N / } " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    
    echo 
    echo "GIT PULL ORIGIN -- Second Argument"
    git pull origin $2
    git status

  fi

  # Getting pretty with space
  echo 
  echo 
  
  # ( My Personal ) I have NPM inside the root folder of project. Do NPM run build if i have any npm source code changes
  # Useful running this one first in while loop if sure no changes in remote or pull remote and compile again for conflicts if any
  read -p "Do you want to perform NPM RUN BUILD ?  { Y = run / N = no / E = end here } " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then

     cd $1
     cd $3
     echo
     echo "PWD  -- your location "
     pwd

     echo " "
     npm run build
     echo " "

  elif [[ $REPLY =~ ^[Ee]$ ]]; then

     echo " "
     echo " "
     # Bye Bye Message Ending forcely
     echo "Ending Script here ..... "

     # Bye Bye Anyway Emoji for fun
     echo
     echo "           ¯\\_\(*-*\)\)_/¯        "

     echo " "
     exit 1
  fi

  # Getting pretty with space
  echo 
  echo 

  # Git push all your changes to Remote branch
  read -p "Do you want to push all your changes ?  { Y / N / } " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then

    cd $1
    echo " "
    echo "Pushing to git remote repository branch $2"
    git push origin $2
    echo 

  fi

  echo 
  echo 

  # Run all these scripts again 
  # Run WHILE LOOP again
  read -p "Do you want to run again ?  { Y / N / } " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo " " 
    echo "Running script again ...... "
    echo 
    runagain=y

  else 
    runagain=n
  fi

done

# Getting pretty with 
echo
echo
echo
# Bye Bye Message
echo "*******************Fairwell*********************"
echo 
# Bye Bye Anyway Emoji for fun
echo "               ¯\\_\(*-*\)\)_/¯                 "
echo 

exit 0