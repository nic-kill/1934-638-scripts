#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/rawdata/
foreach dest ( *.C3086 )
	atlod in=${dest} out=${dest}.uv restfreq=1.420405752d0 options=birdie,xycorr,reweight,noauto |& tee -a miriadimport.log
	echo "Done ${dest}" |& tee -a miriadimport.log
end






