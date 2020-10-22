#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-acc-stats-ali exp/tri1/18.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,s,cs:gunzip -c exp/tri1/ali.${SGE_TASK_ID}.gz|" exp/tri1/18.${SGE_TASK_ID}.acc 
EOF
) >exp/tri1/log/acc.18.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-acc-stats-ali exp/tri1/18.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,s,cs:gunzip -c exp/tri1/ali.${SGE_TASK_ID}.gz|" exp/tri1/18.${SGE_TASK_ID}.acc  ) 2>>exp/tri1/log/acc.18.$SGE_TASK_ID.log >>exp/tri1/log/acc.18.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/log/acc.18.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri1/log/acc.18.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/q/sync/done.14492.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/q/acc.18.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/q/acc.18.sh >>exp/tri1/q/acc.18.log 2>&1
