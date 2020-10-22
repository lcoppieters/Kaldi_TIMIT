#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-acc-stats-ali exp/tri3/20.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2_ali/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk ark:exp/tri3/trans.${SGE_TASK_ID} ark:- ark:- |" "ark,s,cs:gunzip -c exp/tri3/ali.${SGE_TASK_ID}.gz|" exp/tri3/20.${SGE_TASK_ID}.acc 
EOF
) >exp/tri3/log/acc.20.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-acc-stats-ali exp/tri3/20.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2_ali/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk ark:exp/tri3/trans.${SGE_TASK_ID} ark:- ark:- |" "ark,s,cs:gunzip -c exp/tri3/ali.${SGE_TASK_ID}.gz|" exp/tri3/20.${SGE_TASK_ID}.acc  ) 2>>exp/tri3/log/acc.20.$SGE_TASK_ID.log >>exp/tri3/log/acc.20.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/acc.20.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/acc.20.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.23082.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/acc.20.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/acc.20.sh >>exp/tri3/q/acc.20.log 2>&1