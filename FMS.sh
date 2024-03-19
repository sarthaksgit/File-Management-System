#!/bin/bash

# File Management System

rename_file() {
    mv "$1" "$2"
}

while true; do
  # Print options
  echo "Choose an option:"
  echo "1. Create a new file"
  echo "2. Create a new directory"
  echo "3. List files and directories"
  echo "4. Change directory"
  echo "5. Remove file"
  echo "6. Remove directory"
  echo "7. Rename a file"
  echo "8. Quit"

  # Read user input
  read option

  case $option in
    1) # Create a new file
      echo "Enter file name:"
      read filename
      touch $filename
      echo "$filename created."
      ;;
    2) # Create a new directory
      echo "Enter directory name:"
      read dirname
      mkdir $dirname
      echo "$dirname created."
      ;;
    3) # List files and directories
      ls -al
      ;;
    4) # Change directory
      echo "Enter directory path:"
      read dirpath
      cd $dirpath
      echo "Current directory: $(pwd)"
      ;;
    5) # Remove file
      echo "Enter file name:"
      read filename
      rm $filename
      echo "$filename removed."
      ;;
    6) # Remove directory
      echo "Enter directory name:"
      read dirname
      rm -r $dirname
      echo "$dirname removed."
      ;;
    
    7)
        read -p "Enter the current filename: " current_filename
        read -p "Enter the new filename: " new_filename
        rename_file "$current_filename" "$new_filename"
        echo "File renamed successfully!"
        ;;

   8) # Quit
      exit 0
      ;;
    *) # Invalid option
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
done