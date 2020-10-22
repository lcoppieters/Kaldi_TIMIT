#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-phones --per-frame=true exp/tri3/decode_test.si/../final.mdl "ark:gunzip -c exp/tri3/decode_test.si/ali_tmp.*.gz|" "ark,t:|gzip -c >exp/tri3/decode_test.si/ali_frame_tmp.gz" 
EOF
) >exp/tri3/decode_test.si/log/dump_ali_frame.log
time1=`date +"%s"`
 ( ali-to-phones --per-frame=true exp/tri3/decode_test.si/../final.mdl "ark:gunzip -c exp/tri3/decode_test.si/ali_tmp.*.gz|" "ark,t:|gzip -c >exp/tri3/decode_test.si/ali_frame_tmp.gz"  ) 2>>exp/tri3/decode_test.si/log/dump_ali_frame.log >>exp/tri3/decode_test.si/log/dump_ali_frame.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_test.si/log/dump_ali_frame.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_test.si/log/dump_ali_frame.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_test.si/q/sync/done.3147
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_test.si/q/dump_ali_frame.log -l sgpu -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_test.si/q/dump_ali_frame.sh >>exp/tri3/decode_test.si/q/dump_ali_frame.log 2>&1
