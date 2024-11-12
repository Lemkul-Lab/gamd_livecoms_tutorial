#!/bin/bash
dir_codes=/home/hmichel/pyreweighting/
Emax=100
cutoff=10
Xmin=-180
Xmax=181
Ymin=-180
Ymax=181
binx=15
biny=15
data="cv.dat"
T=298

echo "Usage: reweight-2d.sh $Emax $cutoff $binx $biny $data $T"

if [ -f weights.dat ]; then
echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job amdweight_CE -weight weights.dat" | tee -a reweight_variable.log
python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -Xdim $Xmin $Xmax -Ydim $Ymin $Ymax -discX $binx -discY $biny -job amdweight_CE -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-c1-$data.xvg pmf-2D-c1-$data-reweight-discx$binx-discy$biny.xvg
mv -v pmf-c2-$data.xvg pmf-2D-c2-$data-reweight-discx$binx-discy$biny.xvg
mv -v pmf-c3-$data.xvg pmf-2D-c3-$data-reweight-discx$binx-discy$biny.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-$data-reweight-CE2-discx$binx-discy$biny.png

echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight" | tee -a reweight_variable.log
python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight | tee -a reweight_variable.log
mv -v pmf-$data.xvg pmf-2D-$data-noweight-discx$binx-discy$biny.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-$data-noweight-discx$binx-discy$biny.png

else
echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight" | tee -a reweight_variable.log
python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight | tee -a reweight_variable.log
mv -v pmf-$data.xvg pmf-2D-$data-noweight-discx$binx-discy$biny.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-$data-noweight-discx$binx-discy$biny.png
fi # fix_weights.dat

#if [ -f exist.dat ]; then
#echo "exist.dat"

#echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job amdweight -weight fix_weights.dat" | tee -a reweight_variable.log
#python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job amdweight -weight fix_weights.dat | tee -a reweight_variable.log
#mv -v pmf-$data.xvg pmf-2D-$data-reweight-exp-discx$binx-discy$biny.xvg
#mv -v 2D_Free_energy_surface.png pmf-2D-$data-reweight-exp-discx$binx-discy$biny.png

#echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job histo -weight fix_weights.dat" | tee -a reweight_variable.log
#python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job histo -weight fix_weights.dat | tee -a reweight_variable.log
#mv -v histo-$data.xvg histo-2D-$data-discx$binx-discy$biny.dat.xvg

#echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight" | tee -a reweight_variable.log
#python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job noweight | tee -a reweight_variable.log
#mv -v pmf-$data.xvg pmf-2D-$data-noweight-discx$binx-discy$biny.xvg
#mv -v 2D_Free_energy_surface.png pmf-2D-$data-noweight-discx$binx-discy$biny.png

echo "python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -discX $binx -discY $biny -job amd_dV -weight weights.dat" | tee -a reweight_variable.log
python $dir_codes/PyReweighting-2D.py -input $data -T $T -Emax $Emax -cutoff $cutoff -Xdim $Xmin $Xmax -Ydim $Ymin $Ymax -discX $binx -discY $biny -job amd_dV -weight weights.dat | tee -a reweight_variable.log
mv -v dV-stat-2D-$data.xvg dV-stat-2D-$data-reweight-discx$binx-discy$biny.xvg
mv -v dV-anharm-2D-$data.xvg dV-anharm-2D-$data-reweight-discx$binx-discy$biny.xvg

#fi

