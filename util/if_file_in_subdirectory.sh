#!/bin/bash

echo "=============== list modified files ==============="
git diff --name-only HEAD^ HEAD

echo "========== check paths of modified files =========="
git diff --name-only HEAD^ HEAD > files.txt

# takes multiple directories as input
for search_dir in "$@"; do
    # check all modified files
    while IFS= read -r file; do
        echo $file
        if [[ $file == $search_dir/** ]]; then
            echo "Found $file in the '$search_dir' directory"
            echo "Triggering build"
            echo "::set-output name=run_job::true"
            break 2
        else
            echo "::set-output name=run_job::false"
        fi
    done < files.txt
done
