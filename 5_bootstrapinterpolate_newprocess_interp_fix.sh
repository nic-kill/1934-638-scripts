#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles

set log = (/priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log)

date |& tee -a ${log}

set gpcalint = (1)
set gpcalintgap = (0.5)
set gpcalnfbin = (1)


#only april and may 2017 and 2018 have 1419.5.6 data and they are unusable as a result so 1419.5.6 need not be considered 
#should it be required later just add a line identical to instances of 1419.5.2 with the names changed below it

#flagging channels varies with time of year
foreach dest ( 2016-04*.uv.split 2016-05*.uv.split 2016-08*.uv.split 2016-11*.uv.split 2017-02*.uv.split 2019*.uv.split )
	echo "STARTING ${dest}" |& tee -a ${log}
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}
	pwd |& tee -a ${log}
	#remove preivous calibrations
	rm -rf interpolated |& tee -a ${log}
	rm -rf bootstrap |& tee -a ${log}
	#start cal
	mkdir interpolated |& tee -a ${log}
	mkdir bootstrap |& tee -a ${log}
	#move data into the bootstrap directory
	cp -r 1934-638.14* bootstrap/ |& tee -a ${log}
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap
	#make copy of the 1420 for flagging
	cp -r 1934-638.1420.5.* 1934-638.1420.5.6_flaggedHI |& tee -a ${log}

 	#flag the HI line on the new copy
	if ( ${dest} =~ 2016-04*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,550,2800,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-05*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,700,2700,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-08*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,600,3100,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-11*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,700,3050,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2017-02*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,850,2650,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2019*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,650,2800,1,1 flagval=f |& tee -a ${log}

	#flag the 50km/s bump line on the new copy
	if ( ${dest} =~ 2016-04*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,500,3400,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-05*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,400,3400,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-08*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,300,3700,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2016-11*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,400,3700,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2017-02*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,300,3500,1,1 flagval=f |& tee -a ${log}
	if ( ${dest} =~ 2019*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,350,3450,1,1 flagval=f |& tee -a ${log}

	#copy HI flagged 1420 and unflagged in HI 1420 into interpolated folder for calibration, 1419 unneeded
	cp -r 1934-638.1420.5.* ../interpolated/ |& tee -a ${log}

	#calibrate interpolated method, ordering is quite different to bootstrap below
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/interpolated
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 options=interpolate |& tee -a ${log}
	gpcal vis=1934-638.1420.5.6_flaggedHI/ refant=3 interval=$gpcalint options=xyvary nfbin=$gpcalnfbin |& tee -a ${log}
	if ( ${dest} =~ 2019*.uv.split ) then
			gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.4/ |& tee -a ${log} # 2019 has different ID tag for 1420
		else
			gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.6/ |& tee -a ${log}
		endif 

	#now do the bootstrapping
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap 
	mfcal vis=1934-638.1419.5.2 line=channel,5200,400,1,1 refant=3 interval=5 |& tee -a ${log}
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 |& tee -a ${log}
	cp -rf 1934-638.1419.5.2/bandpass 1934-638.1420.5.6_flaggedHI/bandpass |& tee -a ${log}
	delhd in=1934-638.1420.5.6_flaggedHI/gains |& tee -a ${log}
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 options=nopassol |& tee -a ${log}
	gpcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=$gpcalint options=xyvary nfbin=$gpcalnfbin |& tee -a ${log}
	if ( ${dest} =~ 2019*.uv.split ) then
			gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.4/ |& tee -a ${log} # 2019 has different ID tag for 1420
		else
			gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.6/ |& tee -a ${log} #repeated because wildcards not supported in out parameter
		endif
	echo "FINISHED ${dest}" |& tee -a ${log}
end

echo "EVERYTHING IS DONE" |& tee -a ${log}

