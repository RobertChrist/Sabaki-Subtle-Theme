#!/bin/bash

tmp=./tmp; 
src=./src;
dist=./dist;
themes=("subtle_paper" "subtle_dark" "subtle_kaya");

build () {
  mkdir -p $tmp && 
  cp $src/$1/* $tmp && 
  cp $src/shared/* $tmp && 
  concat -o $tmp/styles.css $tmp/*.css && 
  find $tmp/*.css -type f ! -name 'styles.css' -delete && 
  json-merger --pretty --output $tmp/package.json $tmp/*.json && 
  find $tmp/*.json -type f ! -name 'package.json' -delete && 
  asar pack $tmp $dist/$1.asar && 
  npm run wipe_tmp
}

npm run wipe
for theme in ${themes[@]}; do
  build $theme
done
