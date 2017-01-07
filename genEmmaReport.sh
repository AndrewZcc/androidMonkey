#!/bin/bash

echo "\nMonkey-Test: Emma-Report Generator"
echo "[Usage: sh genEmmaReport.sh AUT_Name int(50)]\n"

if [ $# != 2 ]; then
	echo "[Parameters Number Error]"
	echo "[Usage: sh genEmmaReport.sh AUT_Name int(50)]\n"
	exit 1
fi

COMMAND="java -cp /Users/zhchuch/Downloads/adt-bundle-mac-x86_64-20140702/sdk/tools/lib/emma.jar emma report -r html -in coverage.em"
COMTAIL=""

int=1
while(( $int<=$2 ))
do
	COMTAIL=$COMTAIL",coverage"$int".ec"
	let "int++"
done

COMMAND=$COMMAND$COMTAIL
echo $COMMAND
echo ""

cd "./results/"$1"/temp"	# 进入 AUT results 目录
$COMMAND					# 执行 java emma * 命令，直接生成 Report
