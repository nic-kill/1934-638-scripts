#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/


foreach filename ( 1420_bootstrap_merge_fixedfreq 1420_interpolated_merge_fixedfreq )

    invert vis=${filename} map=${filename}.map beam=${filename}.beam robust=2 line=velocity slop=0.5

    clean map=${filename}.map beam=${filename}.beam out=${filename}.clean

    restor model=${filename}.clean beam=${filename}.beam map=${filename}.map out=${filename}_restored.map

    fits in=${filename}_restored.map out=${filename}_restored.fits op=xyout

end

mv *.map *.beam *.clean *.fits ./images/
