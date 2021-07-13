#!/usr/bin/env bash


set -e
set -x
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail

dashboardsDirPath=../../deploy/charts/openebs-monitoring/dashboards
rulessDirPath=../../deploy/charts/openebs-monitoring/rules

generateDashboards(){
	rm -rf $dashboardsDirPath
	mkdir -p $dashboardsDirPath
	jsonnet -J vendor -m $dashboardsDirPath lib/dashboards.jsonnet
	dashboardsFolder=(cStor Jiva LocalPV)
	for i in ${dashboardsFolder[@]}
	do
	    x=`echo $i | awk '{print tolower($0)}'`
		mkdir $dashboardsDirPath/$i
		find ./$dashboardsDirPath  -name "*$x*" |xargs -I{} sh -c "mv {} $dashboardsDirPath/$i/"
	done
}

generateRules(){
	rm -rf $rulessDirPath
	mkdir -p  $rulessDirPath
	jsonnet -J vendor -m $rulessDirPath lib/rules.jsonnet
	rulesFolder=(cStor Jiva Volume)
	for i in ${rulesFolder[@]}
	do
	    x=`echo $i | awk '{print tolower($0)}'`
		mkdir $rulessDirPath/$i
		find ./$rulessDirPath  -name "*$x*" |xargs -I{} sh -c "mv {} $rulessDirPath/$i/"
	done
}

generateDashboards;
generateRules;

