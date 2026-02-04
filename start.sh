#!/bin/bash
#create ./Public/images directory if it doesn't exist
if [ ! -d "./public/images" ]; then
  mkdir -p ./public/images
  echo "Created ./public/images directory."
else
  echo "./public/images directory already exists."
fi

  npm start
