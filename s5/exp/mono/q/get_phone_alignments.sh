#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
set -o pipefail && ali-to-phones --write-lengths=true exp/mono/final.mdl "ark:gunzip -c exp/mono/ali.${SGE_TASK_ID}.gz|" ark,t:- | sed -E "s/^[^ ]+ //" | awk 'BEGIN{FS=" ; "; OFS="\n";} {print "begin " $1; if (NF>1) print "end " $NF; for (n=1;n<=NF;n++) print "all " $n; }' | sort | uniq -c | gzip -c > exp/mono/phone_stats.${SGE_TASK_ID}.gz 
EOF
) >exp/mono/log/get_phone_alignments.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( set -o pipefail && ali-to-phones --write-lengths=true exp/mono/final.mdl "ark:gunzip -c exp/mono/ali.${SGE_TASK_ID}.gz|" ark,t:- | sed -E "s/^[^ ]+ //" | awk 'BEGIN{FS=" ; "; OFS="\n";} {print "begin " $1; if (NF>1) print "end " $NF; for (n=1;n<=NF;n++) print "all " $n; }' | sort | uniq -c | gzip -c > exp/mono/phone_stats.${SGE_TASK_ID}.gz  ) 2>>exp/mono/log/get_phone_alignments.$SGE_TASK_ID.log >>exp/mono/log/get_phone_alignments.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/log/get_phone_alignments.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/mono/log/get_phone_alignments.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/q/sync/done.27429.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/q/get_phone_alignments.log -l q1d -P parole   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/q/get_phone_alignments.sh >>exp/mono/q/get_phone_alignments.log 2>&1
