#!/usr/bin/env bash


set -e
set -x
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail

dashboardsDirPath=../../deploy/charts/openebs-monitoring/dashboards
rulesDirPath=../../deploy/charts/openebs-monitoring/rules

generateDashboards(){
	rm -rf $dashboardsDirPath
	mkdir -p $dashboardsDirPath
	jsonnet -J vendor -m $dashboardsDirPath lib/dashboards.jsonnet
	dashboardsFolder=(cStor Jiva LocalPV npd)
	for i in ${dashboardsFolder[@]}
	do
	    x=`echo $i | awk '{print tolower($0)}'`
		mkdir -p $dashboardsDirPath/$i
		find ./$dashboardsDirPath -type f -name "*$x*" |xargs -I{} sh -c "mv {} $dashboardsDirPath/$i/"
	done
}

generateRules(){
	rm -rf $rulesDirPath
	mkdir -p  $rulesDirPath
	jsonnet -J vendor -m $rulesDirPath lib/rules.jsonnet
	rulesFolder=(cStor Jiva Volume npd)
	for i in ${rulesFolder[@]}
	do
	    x=`echo $i | awk '{print tolower($0)}'`
		mkdir -p $rulesDirPath/$i
		find ./$rulesDirPath -type f -name "*$x*" |xargs -I{} sh -c "mv {} $rulesDirPath/$i/"
	done
}

generateDashboards;
generateRules;

