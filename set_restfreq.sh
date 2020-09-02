#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/

foreach dest ( 2016-04*.uv.split 2016-05*.uv.split 2016-08*.uv.split 2016-11*.uv.split 2017-02*.uv.split )
	echo "STARTING /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap/1934-638.1420.5.6" 
	puthd in=./${dest}/*/1934-638.1420.5.6/restfreq value=1.420405752d0
	echo "DONE ${dest}"
end

foreach dest ( 2019*.uv.split )
        echo "STARTING /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap/1934-638.1420.5.4"
        puthd in=./${dest}/*/1934-638.1420.5.4/restfreq value=1.420405752d0
        echo "DONE ${dest}"
end

echo "ALL DONE"
