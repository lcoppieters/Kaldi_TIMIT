#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gunzip -c exp/tri3/decode_dev.si/phone_stats.*.gz | steps/diagnostic/analyze_phone_length_stats.py exp/tri3/graph 
EOF
) >exp/tri3/decode_dev.si/log/analyze_alignments.log
time1=`date +"%s"`
 ( gunzip -c exp/tri3/decode_dev.si/phone_stats.*.gz | steps/diagnostic/analyze_phone_length_stats.py exp/tri3/graph  ) 2>>exp/tri3/decode_dev.si/log/analyze_alignments.log >>exp/tri3/decode_dev.si/log/analyze_alignments.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_dev.si/log/analyze_alignments.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_dev.si/log/analyze_alignments.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_dev.si/q/sync/done.32500
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_dev.si/q/analyze_alignments.log -l sgpu -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_dev.si/q/analyze_alignments.sh >>exp/tri3/decode_dev.si/q/analyze_alignments.log 2>&1
