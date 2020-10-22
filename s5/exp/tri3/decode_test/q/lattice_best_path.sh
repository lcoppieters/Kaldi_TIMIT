#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
lattice-depth-per-frame "ark:gunzip -c exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz|" "ark,t:|gzip -c > exp/tri3/decode_test/depth_tmp.${SGE_TASK_ID}.gz" ark:- | lattice-best-path --acoustic-scale=0.1 ark:- ark:/dev/null "ark,t:|gzip -c >exp/tri3/decode_test/ali_tmp.${SGE_TASK_ID}.gz" 
EOF
) >exp/tri3/decode_test/log/lattice_best_path.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( lattice-depth-per-frame "ark:gunzip -c exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz|" "ark,t:|gzip -c > exp/tri3/decode_test/depth_tmp.${SGE_TASK_ID}.gz" ark:- | lattice-best-path --acoustic-scale=0.1 ark:- ark:/dev/null "ark,t:|gzip -c >exp/tri3/decode_test/ali_tmp.${SGE_TASK_ID}.gz"  ) 2>>exp/tri3/decode_test/log/lattice_best_path.$SGE_TASK_ID.log >>exp/tri3/decode_test/log/lattice_best_path.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_test/log/lattice_best_path.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_test/log/lattice_best_path.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_test/q/sync/done.4282.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_test/q/lattice_best_path.log -l sgpu -P parole   -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_test/q/lattice_best_path.sh >>exp/tri3/decode_test/q/lattice_best_path.log 2>&1
