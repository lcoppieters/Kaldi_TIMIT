#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
lattice-align-phones exp/tri3/decode_test/../final.mdl "ark:gunzip -c exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz|" ark:- | lattice-to-ctm-conf --acoustic-scale=.20000000 --lm-scale=1.0 ark:- exp/tri3/decode_test/scoring/5.${SGE_TASK_ID}.ctm 
EOF
) >exp/tri3/decode_test/scoring/log/best_path.5.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( lattice-align-phones exp/tri3/decode_test/../final.mdl "ark:gunzip -c exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz|" ark:- | lattice-to-ctm-conf --acoustic-scale=.20000000 --lm-scale=1.0 ark:- exp/tri3/decode_test/scoring/5.${SGE_TASK_ID}.ctm  ) 2>>exp/tri3/decode_test/scoring/log/best_path.5.$SGE_TASK_ID.log >>exp/tri3/decode_test/scoring/log/best_path.5.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_test/scoring/log/best_path.5.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_test/scoring/log/best_path.5.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_test/scoring/q/sync/done.4940.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_test/scoring/q/best_path.5.log -l sgpu -P parole   -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_test/scoring/q/best_path.5.sh >>exp/tri3/decode_test/scoring/q/best_path.5.log 2>&1
