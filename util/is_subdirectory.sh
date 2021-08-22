#!/bin/bash

search_dir=$1

echo "=============== list modified files ==============="
git diff --name-only HEAD^ HEAD

echo "========== check paths of modified files =========="
git diff --name-only HEAD^ HEAD > files.txt
while IFS= read -r file
do
    pwd
    echo $file
    if [[ $(find "$search_dir" -name "$file") ]]; then
        echo "This modified file IS under the '$1' folder."
        echo "::set-output name=run_job::true"
        break
    else
        echo "This modified file is not under the '$1' folder."
        echo "::set-output name=run_job::false"
        break
    fi
done < files.txt