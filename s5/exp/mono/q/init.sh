#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-init-mono --shared-phones=data/lang/phones/sets.int "--train-feats=ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- | subset-feats --n=10 ark:- ark:-|" data/lang/topo 39 exp/mono/0.mdl exp/mono/tree 
EOF
) >exp/mono/log/init.log
time1=`date +"%s"`
 ( gmm-init-mono --shared-phones=data/lang/phones/sets.int "--train-feats=ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- | subset-feats --n=10 ark:- ark:-|" data/lang/topo 39 exp/mono/0.mdl exp/mono/tree  ) 2>>exp/mono/log/init.log >>exp/mono/log/init.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/log/init.log
echo '#' Finished at `date` with status $ret >>exp/mono/log/init.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/q/sync/done.18827.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/q/init.log -l q1d -P parole -l 'buster'   -t 1:1 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/q/init.sh >>exp/mono/q/init.log 2>&1
