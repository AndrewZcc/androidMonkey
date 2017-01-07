#!/bin/bash


#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR=/Users/zhchuch/Desktop/paper/Backup/constrast_experi/ATGT/monkey
APPDIR=/Users/zhchuch/Desktop/paper/Backup/constrast_experi/ATGT/subjects/
RESULTDIR=$DIR/results/

source $DIR/env.sh
echo "PATH=  $PATH"

cd $APPDIR
#for p in `ls -d */`; do
for p in `cat $DIR/projects.txt`; do

  echo "Setting up AVD"
  cd $DIR
  ./setupEmu.sh monkeyDevice

  echo "@@@@@@ Processing project " $p "@@@@@@@"
  mkdir -p $RESULTDIR$p
  cd $APPDIR$p
  echo "** BUILDING APP " $p
  #ant clean
  #ant emma debug install &> $RESULTDIR$p/build.log
  ant installd >> $RESULTDIR$p/install.log
  cp bin/coverage.em $RESULTDIR$p/
  app=`ls bin/*-debug.apk`

  echo "** PROCESSING APP " $app
  package=`aapt d xmltree $app AndroidManifest.xml | grep package | awk 'BEGIN {FS="\""}{print $2}'`

  echo "** RUNNING LOGCAT"
  adb logcat >> $RESULTDIR$p/monkey.logcat &

  echo "** DUMPING INTERMEDIATE COVERAGE "
  cd $DIR
  ./dumpCoverage.sh $RESULTDIR$p >> $RESULTDIR$p/icoverage.log &

  date1=$(date +"%s")
  echo "** RUNNING MONKEY FOR" $package
  #timeout 1h adb shell monkey -p $package -v 1000000 --throttle 200 --ignore-crashes --ignore-timeouts --ignore-security-exceptions &> $RESULTDIR$p/monkey.log
  gtimeout 1800 adb shell monkey -p $package -v --throttle 500 --ignore-crashes --ignore-timeouts --ignore-security-exceptions 1000000 >> $RESULTDIR$p/monkey.log
  echo "-- FINISHED MONKEY"
  date2=$(date +"%s")
  diff=$(($date2-$date1))
  echo "Monkey-Testing: took $(($diff / 60)) minutes and $(($diff % 60)) seconds."

  adb shell am broadcast -a edu.gatech.m3.emma.COLLECT_COVERAGE
  adb pull /mnt/sdcard/coverage.ec $RESULTDIR$p/coverage.ec

  NOW=$(date +"%m-%d-%Y-%H-%M")
  echo $NOW.$p >> $RESULTDIR/status.log

  adb emu kill

  killall dumpCoverage.sh
  killall sleep

done
