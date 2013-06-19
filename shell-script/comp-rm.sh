#!/bin/bash
#Author: oopsmonk
#File: comp-rm.sh
#Date: 2013/06/19
#
#Compare the same file in two folders and remove it.
#

function usage(){
    echo "Find the same file in two folders and remove it."
    echo "usage : ./comp-rm.sh target-dir source-dir"
    echo "remove the same files in target-dir."
}

if [ $# -ne 2 ]; then 
    usage
    exit 1
fi

target_dir=$1
source_dir=$2
f_list1=$(find "$target_dir" -type f)
f_list2=$(find "$source_dir" -type f)


for i in $f_list1; do 
    echo $f_list2 | grep $(basename $i) >/dev/null && hit_str+=$i";"
done

if [ -z $hit_str ]; then
    echo "list is empty.."
    exit 0
fi

#echo "hit_str = $hit_str"
export IFS=";"
for hit_file in $hit_str; do
    echo "$hit_file"
done

echo "Do you want to remove these files?"
read -p "Press 'Ctrl+C' stop, 'Enter' key to continue..."

for hit_file in $hit_str; do
    echo "removing... $hit_file"
    rm -f $hit_file
done

exit 0
