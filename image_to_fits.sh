#!/bin/csh

#miriad task to crop in space and velocity

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/images

foreach filename ( 1420_bootstrap_merge_fixedfreq_restored 1420_interpolated_merge_fixedfreq_restored )

    fits in=${filename}.map out=${filename}.fits op=xyout

end