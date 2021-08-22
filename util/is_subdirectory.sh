#!/bin/bash

echo "=============== list modified files ==============="
git diff --name-only HEAD^ HEAD

echo "========== check paths of modified files =========="
git diff --name-only HEAD^ HEAD > files.txt
while IFS= read -r file
do
    echo $file
    if [[ $file != $1/** ]]; then
        echo "This modified file is not under the '$1' folder."
        echo "::set-output name=run_job::false"
        break
    else
        echo "This modified file IS under the '$1' folder."
        echo "::set-output name=run_job::true"
        break
    fi
done < files.txt