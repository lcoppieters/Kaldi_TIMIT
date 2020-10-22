#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
convert-ali exp/tri2_ali/final.mdl exp/tri3/1.mdl exp/tri3/tree "ark:gunzip -c exp/tri2_ali/ali.${SGE_TASK_ID}.gz|" "ark:|gzip -c >exp/tri3/ali.${SGE_TASK_ID}.gz" 
EOF
) >exp/tri3/log/convert.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( convert-ali exp/tri2_ali/final.mdl exp/tri3/1.mdl exp/tri3/tree "ark:gunzip -c exp/tri2_ali/ali.${SGE_TASK_ID}.gz|" "ark:|gzip -c >exp/tri3/ali.${SGE_TASK_ID}.gz"  ) 2>>exp/tri3/log/convert.$SGE_TASK_ID.log >>exp/tri3/log/convert.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/convert.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/convert.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.11262.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/convert.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/convert.sh >>exp/tri3/q/convert.log 2>&1
