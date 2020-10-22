#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-post "ark:gunzip -c exp/tri2/ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri2/12.mdl ark:- ark:- | gmm-acc-mllt --rand-prune=4.0 exp/tri2/12.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2/6.mat ark:- ark:- |" ark:- exp/tri2/12.${SGE_TASK_ID}.macc 
EOF
) >exp/tri2/log/macc.12.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( ali-to-post "ark:gunzip -c exp/tri2/ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri2/12.mdl ark:- ark:- | gmm-acc-mllt --rand-prune=4.0 exp/tri2/12.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2/6.mat ark:- ark:- |" ark:- exp/tri2/12.${SGE_TASK_ID}.macc  ) 2>>exp/tri2/log/macc.12.$SGE_TASK_ID.log >>exp/tri2/log/macc.12.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/log/macc.12.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri2/log/macc.12.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/q/sync/done.32642.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/q/macc.12.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/q/macc.12.sh >>exp/tri2/q/macc.12.log 2>&1
