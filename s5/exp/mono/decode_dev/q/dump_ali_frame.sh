#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-phones --per-frame=true exp/mono/decode_dev/../final.mdl "ark:gunzip -c exp/mono/decode_dev/ali_tmp.*.gz|" "ark,t:|gzip -c >exp/mono/decode_dev/ali_frame_tmp.gz" 
EOF
) >exp/mono/decode_dev/log/dump_ali_frame.log
time1=`date +"%s"`
 ( ali-to-phones --per-frame=true exp/mono/decode_dev/../final.mdl "ark:gunzip -c exp/mono/decode_dev/ali_tmp.*.gz|" "ark,t:|gzip -c >exp/mono/decode_dev/ali_frame_tmp.gz"  ) 2>>exp/mono/decode_dev/log/dump_ali_frame.log >>exp/mono/decode_dev/log/dump_ali_frame.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/decode_dev/log/dump_ali_frame.log
echo '#' Finished at `date` with status $ret >>exp/mono/decode_dev/log/dump_ali_frame.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/decode_dev/q/sync/done.19491
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/decode_dev/q/dump_ali_frame.log -l q1d -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/decode_dev/q/dump_ali_frame.sh >>exp/mono/decode_dev/q/dump_ali_frame.log 2>&1
