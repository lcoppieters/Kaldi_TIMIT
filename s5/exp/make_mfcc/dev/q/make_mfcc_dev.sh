#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
compute-mfcc-feats --write-utt2dur=ark,t:exp/make_mfcc/dev/utt2dur.${SGE_TASK_ID} --verbose=2 --config=conf/mfcc.conf scp,p:exp/make_mfcc/dev/wav_dev.${SGE_TASK_ID}.scp ark:- | copy-feats --write-num-frames=ark,t:exp/make_mfcc/dev/utt2num_frames.${SGE_TASK_ID} --compress=true ark:- ark,scp:/idiap/user/lcoppieters/kaldi/egs/timit/s5/mfcc/raw_mfcc_dev.${SGE_TASK_ID}.ark,/idiap/user/lcoppieters/kaldi/egs/timit/s5/mfcc/raw_mfcc_dev.${SGE_TASK_ID}.scp 
EOF
) >exp/make_mfcc/dev/make_mfcc_dev.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( compute-mfcc-feats --write-utt2dur=ark,t:exp/make_mfcc/dev/utt2dur.${SGE_TASK_ID} --verbose=2 --config=conf/mfcc.conf scp,p:exp/make_mfcc/dev/wav_dev.${SGE_TASK_ID}.scp ark:- | copy-feats --write-num-frames=ark,t:exp/make_mfcc/dev/utt2num_frames.${SGE_TASK_ID} --compress=true ark:- ark,scp:/idiap/user/lcoppieters/kaldi/egs/timit/s5/mfcc/raw_mfcc_dev.${SGE_TASK_ID}.ark,/idiap/user/lcoppieters/kaldi/egs/timit/s5/mfcc/raw_mfcc_dev.${SGE_TASK_ID}.scp  ) 2>>exp/make_mfcc/dev/make_mfcc_dev.$SGE_TASK_ID.log >>exp/make_mfcc/dev/make_mfcc_dev.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/make_mfcc/dev/make_mfcc_dev.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/make_mfcc/dev/make_mfcc_dev.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/make_mfcc/dev/q/sync/done.20066.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/make_mfcc/dev/q/make_mfcc_dev.log -l q1d -P parole   -t 1:10 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/make_mfcc/dev/q/make_mfcc_dev.sh >>exp/make_mfcc/dev/q/make_mfcc_dev.log 2>&1
