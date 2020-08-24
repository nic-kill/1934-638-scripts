#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/
foreach subfile ( 20*.uv.split )
    echo "STARTING ${subfile}" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/combinedimages/combinecalplots_bysubfile.log
    gs -sDEVICE=ps2write \
    -dNOPAUSE -dBATCH -dSAFER \
    -sOutputFile=/priv/myrtle1/gaskap/nickill/1934project/uvfiles/${subfile}/bootstrap/calimages_merged.ps \
    /priv/myrtle1/gaskap/nickill/1934project/uvfiles/${subfile}/bootstrap/*.ps \
    echo "FINISHED ${subfile}" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/combinedimages/combinecalplots_bysubfile.log
end
echo "ALL DONE" |& tee -a /priv/myrtle1/gaskap/nickill/1934project/uvfiles/combinedimages/combinecalplots_bysubfile.log
