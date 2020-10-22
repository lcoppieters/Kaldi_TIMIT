#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gunzip -c exp/tri3/decode_test.si/lat.${SGE_TASK_ID}.gz | lattice-to-post --acoustic-scale=0.083333 ark:- ark:- | weight-silence-post 0.01 1 exp/tri3/final.alimdl ark:- ark:- | gmm-post-to-gpost exp/tri3/final.alimdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark:- ark:- | gmm-est-fmllr-gpost --fmllr-update-type=full --spk2utt=ark:data/test/split5/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark,s,cs:- ark:exp/tri3/decode_test/pre_trans.${SGE_TASK_ID} 
EOF
) >exp/tri3/decode_test/log/fmllr_pass1.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gunzip -c exp/tri3/decode_test.si/lat.${SGE_TASK_ID}.gz | lattice-to-post --acoustic-scale=0.083333 ark:- ark:- | weight-silence-post 0.01 1 exp/tri3/final.alimdl ark:- ark:- | gmm-post-to-gpost exp/tri3/final.alimdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark:- ark:- | gmm-est-fmllr-gpost --fmllr-update-type=full --spk2utt=ark:data/test/split5/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" ark,s,cs:- ark:exp/tri3/decode_test/pre_trans.${SGE_TASK_ID}  ) 2>>exp/tri3/decode_test/log/fmllr_pass1.$SGE_TASK_ID.log >>exp/tri3/decode_test/log/fmllr_pass1.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_test/log/fmllr_pass1.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_test/log/fmllr_pass1.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_test/q/sync/done.4072.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_test/q/fmllr_pass1.log -l sgpu -P parole -tc 25   -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_test/q/fmllr_pass1.sh >>exp/tri3/decode_test/q/fmllr_pass1.log 2>&1
