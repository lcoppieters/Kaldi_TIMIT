#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
cp exp/tri1/decode_test/scoring/stm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/stm_39phn && cp exp/tri1/decode_test/scoring/${SGE_TASK_ID}.ctm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/ctm_39phn && /idiap/user/lcoppieters/kaldi/tools/sctk/bin/hubscr.pl -p /idiap/user/lcoppieters/kaldi/tools/sctk/bin -V -l english -h hub5 -g exp/tri1/decode_test/scoring/glm_39phn -r exp/tri1/decode_test/score_${SGE_TASK_ID}/stm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/ctm_39phn 
EOF
) >exp/tri1/decode_test/scoring/log/score.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( cp exp/tri1/decode_test/scoring/stm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/stm_39phn && cp exp/tri1/decode_test/scoring/${SGE_TASK_ID}.ctm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/ctm_39phn && /idiap/user/lcoppieters/kaldi/tools/sctk/bin/hubscr.pl -p /idiap/user/lcoppieters/kaldi/tools/sctk/bin -V -l english -h hub5 -g exp/tri1/decode_test/scoring/glm_39phn -r exp/tri1/decode_test/score_${SGE_TASK_ID}/stm_39phn exp/tri1/decode_test/score_${SGE_TASK_ID}/ctm_39phn  ) 2>>exp/tri1/decode_test/scoring/log/score.$SGE_TASK_ID.log >>exp/tri1/decode_test/scoring/log/score.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/decode_test/scoring/log/score.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri1/decode_test/scoring/log/score.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/decode_test/scoring/q/sync/done.24191.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/decode_test/scoring/q/score.log -l q1d -P parole   -t 1:10 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/decode_test/scoring/q/score.sh >>exp/tri1/decode_test/scoring/q/score.log 2>&1
