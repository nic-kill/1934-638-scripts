#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles

#date |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcalplots.log

#remove previous plots
rm /priv/myrtle1/gaskap/nickill/1934project/logs_and_plots/* |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log

#include calibrated directories
foreach dest ( 2016*.uv.split 2017-02*.uv.split 2019-*.uv.split )
	echo "##########STARTING ${dest}##########" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
	#plot for bootstrapping
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap
	foreach subdestboot ( 1934-638.1420.?.? )
		echo "##########STARTING bootstrap ${dest} ${subdestboot}##########" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
		uvspec vis=${subdestboot} stokes=ii interval=1e9 options=nobase,avall axis=velocity,amplitude device=../../../logs_and_plots/${dest}.ps/cps nxy=1,1 log=../../../logs_and_plots/${dest}.log |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
		echo "##########FINISHED bootstrap ${dest} ${subdestboot}##########" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
	end
	echo "##########FINISHED ${dest}##########" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
end
echo "##########ALL DONE##########" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log

#date |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/subfilescheck.log
