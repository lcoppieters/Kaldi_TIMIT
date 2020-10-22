#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
lattice-determinize-pruned --acoustic-scale=0.083333 --beam=4.0 "ark:gunzip -c exp/tri3/decode_dev/lat.tmp.${SGE_TASK_ID}.gz|" ark:- | lattice-to-post --acoustic-scale=0.083333 ark:- ark:- | weight-silence-post 0.01 1 exp/tri3/final.mdl ark:- ark:- | gmm-est-fmllr --fmllr-update-type=full --spk2utt=ark:data/dev/split5/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk scp:data/dev/split5/${SGE_TASK_ID}/cmvn.scp scp:data/dev/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk ark:exp/tri3/decode_dev/pre_trans.${SGE_TASK_ID} ark:- ark:- |" ark,s,cs:- ark:exp/tri3/decode_dev/trans_tmp.${SGE_TASK_ID} && compose-transforms --b-is-affine=true ark:exp/tri3/decode_dev/trans_tmp.${SGE_TASK_ID} ark:exp/tri3/decode_dev/pre_trans.${SGE_TASK_ID} ark:exp/tri3/decode_dev/trans.${SGE_TASK_ID} 
EOF
) >exp/tri3/decode_dev/log/fmllr_pass2.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( lattice-determinize-pruned --acoustic-scale=0.083333 --beam=4.0 "ark:gunzip -c exp/tri3/decode_dev/lat.tmp.${SGE_TASK_ID}.gz|" ark:- | lattice-to-post --acoustic-scale=0.083333 ark:- ark:- | weight-silence-post 0.01 1 exp/tri3/final.mdl ark:- ark:- | gmm-est-fmllr --fmllr-update-type=full --spk2utt=ark:data/dev/split5/${SGE_TASK_ID}/spk2utt exp/tri3/final.mdl "ark,s,cs:apply-cmvn  --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk scp:data/dev/split5/${SGE_TASK_ID}/cmvn.scp scp:data/dev/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk ark:exp/tri3/decode_dev/pre_trans.${SGE_TASK_ID} ark:- ark:- |" ark,s,cs:- ark:exp/tri3/decode_dev/trans_tmp.${SGE_TASK_ID} && compose-transforms --b-is-affine=true ark:exp/tri3/decode_dev/trans_tmp.${SGE_TASK_ID} ark:exp/tri3/decode_dev/pre_trans.${SGE_TASK_ID} ark:exp/tri3/decode_dev/trans.${SGE_TASK_ID}  ) 2>>exp/tri3/decode_dev/log/fmllr_pass2.$SGE_TASK_ID.log >>exp/tri3/decode_dev/log/fmllr_pass2.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_dev/log/fmllr_pass2.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_dev/log/fmllr_pass2.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_dev/q/sync/done.1259.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_dev/q/fmllr_pass2.log -l sgpu -P parole -tc 25   -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_dev/q/fmllr_pass2.sh >>exp/tri3/decode_dev/q/fmllr_pass2.log 2>&1
