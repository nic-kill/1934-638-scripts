#!/bin/csh

cd /priv/myrtle1/gaskap/nickill/1934project/uvfiles/


foreach filename ( 1420_bootstrap_merge 1420_interpolated_merge )

    invert vis=${filename} map=${filename}.map beam=${filename}.beam robust=2 line=velocity slop=0.5

    clean map=${filename}.map beam=${filename}.beam out=${filename}.clean

    restor model=${filename}.clean beam=${filename}.beam map=${filename}.map out=${filename}_restored.map
end

mv *.map *.beam *.clean ./images/