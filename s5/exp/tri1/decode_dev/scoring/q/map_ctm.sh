#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
mkdir exp/tri1/decode_dev/score_${SGE_TASK_ID} ; cat exp/tri1/decode_dev/scoring/${SGE_TASK_ID}.ctm | utils/int2sym.pl -f 5 exp/tri1/graph/words.txt | local/timit_norm_trans.pl -i - -m conf/phones.60-48-39.map -from 48 -to 39 > exp/tri1/decode_dev/scoring/${SGE_TASK_ID}.ctm_39phn 
EOF
) >exp/tri1/decode_dev/scoring/log/map_ctm.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( mkdir exp/tri1/decode_dev/score_${SGE_TASK_ID} ; cat exp/tri1/decode_dev/scoring/${SGE_TASK_ID}.ctm | utils/int2sym.pl -f 5 exp/tri1/graph/words.txt | local/timit_norm_trans.pl -i - -m conf/phones.60-48-39.map -from 48 -to 39 > exp/tri1/decode_dev/scoring/${SGE_TASK_ID}.ctm_39phn  ) 2>>exp/tri1/decode_dev/scoring/log/map_ctm.$SGE_TASK_ID.log >>exp/tri1/decode_dev/scoring/log/map_ctm.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/decode_dev/scoring/log/map_ctm.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri1/decode_dev/scoring/log/map_ctm.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/decode_dev/scoring/q/sync/done.22625.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/decode_dev/scoring/q/map_ctm.log -l q1d -P parole   -t 1:10 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/decode_dev/scoring/q/map_ctm.sh >>exp/tri1/decode_dev/scoring/q/map_ctm.log 2>&1
