#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gunzip -c exp/tri1/decode_dev/depth_tmp.*.gz | steps/diagnostic/analyze_lattice_depth_stats.py exp/tri1/graph exp/tri1/decode_dev/ali_frame_tmp.gz 
EOF
) >exp/tri1/decode_dev/log/analyze_lattice_depth_stats.log
time1=`date +"%s"`
 ( gunzip -c exp/tri1/decode_dev/depth_tmp.*.gz | steps/diagnostic/analyze_lattice_depth_stats.py exp/tri1/graph exp/tri1/decode_dev/ali_frame_tmp.gz  ) 2>>exp/tri1/decode_dev/log/analyze_lattice_depth_stats.log >>exp/tri1/decode_dev/log/analyze_lattice_depth_stats.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/decode_dev/log/analyze_lattice_depth_stats.log
echo '#' Finished at `date` with status $ret >>exp/tri1/decode_dev/log/analyze_lattice_depth_stats.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/decode_dev/q/sync/done.21516
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/decode_dev/q/analyze_lattice_depth_stats.log -l q1d -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/decode_dev/q/analyze_lattice_depth_stats.sh >>exp/tri1/decode_dev/q/analyze_lattice_depth_stats.log 2>&1
