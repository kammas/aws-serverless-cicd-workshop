#!/bin/bash

download_template() {
    git clone --branch 2.4.0 https://github.com/matcornic/hugo-theme-learn.git workshop/themes/learn
}

build_javascript_workshop() {
    download_template
    # Delete all java files so they don't show up in the workshop
    find . -type f -name '*.java.en.md' -delete
    build_hugo
}

build_java_workshop() {
    download_template
    # Find all files named _index.java.en.md and rename them to _index.en.md
    # to overwrite the Javascript files.
    find . -name '*.java.en.md' -exec sh -c 'mv "$0" "${0%.java.en.md}.en.md"' {} \; 
    build_hugo
}

build_hugo() {
    hugo --source workshop --destination ../public --quiet
}

language=$1
if [ "$language" = "javascript" ]; then
    echo "Building javascript workshop"
    build_javascript_workshop
elif [ "$language" = "java" ]; then
    echo "Building java workshop"
    build_java_workshop
else
    # Default to javascript
    echo "Building javascript workshop"
    build_javascript_workshop
fi
