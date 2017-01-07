#!/bin/bash

echo "\nMonkey-Test: EC-file Detect & Rename"
echo "[Usage: sh rename_ec.sh AUT_Name]\n"
#eg. sh rename_ec.sh whohasmystuff-1.0.7

if [ $# != 1 ]; then
	echo "[Parameters Number Error]"
	echo "[Usage: sh rename_ec.sh AUT_Name]"
	exit 1
fi

AUT_Dir=$1
#eg. AUT_Dir=net.fercanet.LNM_3_src

rm -rf "./results/"$AUT_Dir"/temp" 
mkdir "./results/"$AUT_Dir"/temp"
i=1
for file in `find "./results/"$AUT_Dir -name "*.ec"`; do
	#echo $file" --> ec file: number "$i
	cp $file "./results/"$AUT_Dir"/temp/coverage"$i".ec"
	i=`expr $i + 1`
done

cp "./results/"$AUT_Dir"/coverage.em" "./results/"$AUT_Dir"/temp/coverage.em"
