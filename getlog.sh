#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "git is not installed. Please install git first."
    exit 1
fi

# Check if in a git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "This script must be run inside a git repository."
    exit 1
fi

# Fetch all tags
git fetch --tags

# Get a list of tags
tags=($(git tag --sort=version:refname))

# Initialize changelog
changelog="Changelog\n"
changelog+="====================\n\n"

# Loop through tags to generate changelog entries
for ((i=${#tags[@]}-1; i>0; i--)); do
    tag1=${tags[i]}
    tag2=${tags[i-1]}
    
    # Get the commit messages between two tags
    commit_messages=$(git log --oneline "$tag2".."$tag1")

    # Add to changelog
    if [ -n "$commit_messages" ]; then
        changelog+="## $tag1\n"
        changelog+="$commit_messages\n\n"
    fi
done

# Remove trailing newlines and output the changelog to a file or stdout
changelog=$(echo -e "$changelog" | sed '/^[[:space:]]*$/d' | sed '/^$/d')  # Remove any blank lines
echo -e "$changelog"
