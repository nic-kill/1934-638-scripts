#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles

date |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log

set gpcalint = (1)
set gpcalintgap = (0.5)
set gpcalnfbin = (1)

#only april and may 2017 and 2018 have 1419.5.6 data and they are unusable as a result so 1419.5.6 need not be considered 
#should it be required later just add a line identical to instances of 1419.5.2 with the names changed below it

#flagging channels varies with time of year
foreach dest ( 2016-04*.uv.split 2016-05*.uv.split 2016-08*.uv.split 2016-11*.uv.split 2017-02*.uv.split 2019*.uv.split )
	echo "STARTING ${dest}" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}
	pwd |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	#remove preivous calibrations
	rm -rf interpolated |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	rm -rf bootstrap |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	#start cal
	mkdir interpolated |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	mkdir bootstrap |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	#move data into the bootstrap directory
	cp -r 1934-638.14* bootstrap/ |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap
	#make copy of the 1420 for flagging
	cp -r 1934-638.1420.5.* 1934-638.1420.5.6_flaggedHI |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log

 	#flag the HI line on the new copy
	if ( ${dest} =~ 2016-04*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,230,3000,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2016-05*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,230,3000,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2016-08*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,200,3370,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2016-11*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,200,3390,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2017-02*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,300,2990,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2019*.uv.split ) uvflag vis=1934-638.1420.5.6_flaggedHI line=channel,200,3080,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log

	#copy HI flagged 1420 and unflagged in HI 1419 into interpolated folder for calibration
	cp -r 1934-638.1420.5.6_flaggedHI ../interpolated/ |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	cp -r 1934-638.1419.5.2 ../interpolated/ |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	#Compute sols through interpolation method
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/interpolated
 
	#flag HI line in 1419, this is only done for the interpolation method
	if ( ${dest} =~ 2016-04*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,200,970,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2016-05*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,200,970,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2016-08*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,220,1350,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
    if ( ${dest} =~ 2016-11*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,250,1300,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2017-02*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,200,1050,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2019*.uv.split ) uvflag vis=1934-638.1419.5.2 line=channel,260,970,1,1 flagval=f |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log

	#calibrate interpolated method
	mfcal vis=1934-638.1419.5.2 line=channel,5200,400,1,1 refant=3 interval=5 options=interpolate |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 options=interpolate |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	gpcal vis=1934-638.1419.5.2 refant=3 interval=$gpcalint options=xyvary nfbin=$gpcalnfbin |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	gpcal vis=1934-638.1420.5.6_flaggedHI/ refant=3 interval=$gpcalint options=xyvary nfbin=$gpcalnfbin |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	
	#now do the bootstrapping
	cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${dest}/bootstrap 
	mfcal vis=1934-638.1419.5.2 line=channel,5200,400,1,1 refant=3 interval=5 |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	cp -rf 1934-638.1419.5.2/bandpass 1934-638.1420.5.6_flaggedHI/bandpass |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	delhd in=1934-638.1420.5.6_flaggedHI/gains |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	mfcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=5 options=nopassol |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	gpcal vis=1934-638.1420.5.6_flaggedHI/ line=channel,5200,400,1,1 refant=3 interval=$gpcalint options=xyvary nfbin=$gpcalnfbin |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
	if ( ${dest} =~ 2019*.uv.split ) gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.4/ |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log # 2019 has different ID tag for 1420
	gpcopy vis=1934-638.1420.5.6_flaggedHI/ out=1934-638.1420.5.6/ |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log #repeated because wildcards not supported in out parameter
	echo "FINISHED ${dest}" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log
end

echo "EVERYTHING IS DONE" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/miriadcal.log

