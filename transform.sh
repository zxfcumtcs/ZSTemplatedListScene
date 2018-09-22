#! /bin/bash

function transformFileName() {
    # $1: src path
    # $2: tar path
    # $3: transform src
    # $4: transform tar
    for file in `ls $1`
    do
	tarFile=$2"/"${file//$3/$4}
        if [ -d $1"/"$file ]
        then
	    mkdir $tarFile
	    echo make dir $tarFile
            transformFileName $1"/"$file $tarFile $3 $4
        else
            srcFile=$1"/"$file
            cp $srcFile $tarFile
	    echo copy file $tarFile
        fi
    done
} 

if [ $# != 1 ]
then
    echo 'USAGE: sh '$0' TargetName'
    exit 1;
fi
 
mkdir $1
transformFileName Template $1 Template $1
sed -i '.bak' 's/Template/'$1'/g' `grep Template -rl $1`
find $1 -name '*.bak' -exec rm -rf {} \;
echo done.
