#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-post "ark:gunzip -c exp/tri3/ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri3/2.mdl ark:- ark:- | gmm-est-fmllr --fmllr-update-type=full --spk2utt=ark:data/train/split30/${SGE_TASK_ID}/spk2utt exp/tri3/2.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2_ali/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk ark,s,cs:exp/tri3/trans.${SGE_TASK_ID} ark:- ark:- |" ark:- ark:exp/tri3/tmp_trans.${SGE_TASK_ID} 
EOF
) >exp/tri3/log/fmllr.2.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( ali-to-post "ark:gunzip -c exp/tri3/ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri3/2.mdl ark:- ark:- | gmm-est-fmllr --fmllr-update-type=full --spk2utt=ark:data/train/split30/${SGE_TASK_ID}/spk2utt exp/tri3/2.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri2_ali/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk ark,s,cs:exp/tri3/trans.${SGE_TASK_ID} ark:- ark:- |" ark:- ark:exp/tri3/tmp_trans.${SGE_TASK_ID}  ) 2>>exp/tri3/log/fmllr.2.$SGE_TASK_ID.log >>exp/tri3/log/fmllr.2.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/fmllr.2.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/fmllr.2.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.14428.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/fmllr.2.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/fmllr.2.sh >>exp/tri3/q/fmllr.2.log 2>&1
