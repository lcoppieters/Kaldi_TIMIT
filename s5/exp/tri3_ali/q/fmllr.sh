#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-post "ark:gunzip -c exp/tri3_ali/pre_ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri3/final.alimdl ark:- ark:- | gmm-post-to-gpost exp/tri3/final.alimdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark:- ark:- | gmm-est-fmllr-gpost --fmllr-update-type=full --spk2utt=ark:data/train/split30/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark,s,cs:- ark:exp/tri3_ali/trans.${SGE_TASK_ID} 
EOF
) >exp/tri3_ali/log/fmllr.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( ali-to-post "ark:gunzip -c exp/tri3_ali/pre_ali.${SGE_TASK_ID}.gz|" ark:- | weight-silence-post 0.0 1 exp/tri3/final.alimdl ark:- ark:- | gmm-post-to-gpost exp/tri3/final.alimdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark:- ark:- | gmm-est-fmllr-gpost --fmllr-update-type=full --spk2utt=ark:data/train/split30/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark,s,cs:- ark:exp/tri3_ali/trans.${SGE_TASK_ID}  ) 2>>exp/tri3_ali/log/fmllr.$SGE_TASK_ID.log >>exp/tri3_ali/log/fmllr.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3_ali/log/fmllr.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3_ali/log/fmllr.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3_ali/q/sync/done.5809.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3_ali/q/fmllr.log -l sgpu -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3_ali/q/fmllr.sh >>exp/tri3_ali/q/fmllr.log 2>&1
