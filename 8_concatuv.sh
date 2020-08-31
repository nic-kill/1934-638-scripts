#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles

#uvcat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/2016-*/bootstrap/*1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/allbootstrap1420merge.uv
echo "Starting.." |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

#merge the bootstrap, wildcards should i think capture the 1420 data for each processing but not the flagged HI line
UvCat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/*.uv.split/bootstrap/*1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/1420_bootstrap_merge.uv
echo "Bootstrap completed" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

#merge the interpolated
UvCat vis=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/*.uv.split/interpolated/*1420.5.? out=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/1420_interpolated_merge.uv
echo "Interpolated completed" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

echo "ALL DONE!!!" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadconcat.log

