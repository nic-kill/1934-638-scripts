#!/bin/csh

#miriad task to crop in space and velocity

cd /priv/myrtle1/gaskap/nickill/uvfiles/images

foreach filename ( 1420_bootstrap_merge_restored 1420_interpolated_merge_restored )

    fits in=${filename}.map out=${filename}.fits op=xyout line=velocity
    
end












