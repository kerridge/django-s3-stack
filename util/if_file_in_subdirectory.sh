#!/bin/bash

search_dir=$1

echo "=============== list modified files ==============="
git diff --name-only HEAD^ HEAD

echo "========== check paths of modified files =========="
git diff --name-only HEAD^ HEAD > files.txt
while IFS= read -r file
do
    echo $file
    if [[ $file == $search_dir/** ]]; then
        echo "Found $file in the '$search_dir' directory"
        echo "::set-output name=run_job::true"
        break
    else
        echo "::set-output name=run_job::false"
    fi
done < files.txt
