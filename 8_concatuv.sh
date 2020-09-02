#!/bin/csh

#######################
#######################
#######################
#######################
#DOESN'T RUN AS SCRIPT NEEDS TO BE RUN IN BASH TERMINAL DIRECTLY, 
#I THINK IT'S BECAUSE OF HOW THE WILDCARDS ARE INTERPRETED IN BASH VS CSH
#######################
#######################
#######################
#######################

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles

#uvcat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/2016-*/bootstrap/*1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/allbootstrap1420merge.uv
echo "Starting.." |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

#merge the bootstrap, wildcards should i think capture the 1420 data for each processing but not the flagged HI line
uvcat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/*/bootstrap/1934-638.1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/1420_bootstrap_merge
echo "Bootstrap completed" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

#merge the interpolated
uvcat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/*/interpolated/1934-638.1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/1420_interpolated_merge
echo "Interpolated completed" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

echo "ALL DONE!!!" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log
