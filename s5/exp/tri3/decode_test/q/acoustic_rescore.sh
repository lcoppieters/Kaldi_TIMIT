#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-rescore-lattice exp/tri3/final.mdl "ark:gunzip -c exp/tri3/decode_test/lat.tmp.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk ark:exp/tri3/decode_test/trans.${SGE_TASK_ID} ark:- ark:- |" ark:- | lattice-determinize-pruned --acoustic-scale=0.083333 --beam=6.0 ark:- "ark:|gzip -c > exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz" && rm exp/tri3/decode_test/lat.tmp.${SGE_TASK_ID}.gz 
EOF
) >exp/tri3/decode_test/log/acoustic_rescore.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-rescore-lattice exp/tri3/final.mdl "ark:gunzip -c exp/tri3/decode_test/lat.tmp.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk scp:data/test/split5/${SGE_TASK_ID}/cmvn.scp scp:data/test/split5/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/test/split5/${SGE_TASK_ID}/utt2spk ark:exp/tri3/decode_test/trans.${SGE_TASK_ID} ark:- ark:- |" ark:- | lattice-determinize-pruned --acoustic-scale=0.083333 --beam=6.0 ark:- "ark:|gzip -c > exp/tri3/decode_test/lat.${SGE_TASK_ID}.gz" && rm exp/tri3/decode_test/lat.tmp.${SGE_TASK_ID}.gz  ) 2>>exp/tri3/decode_test/log/acoustic_rescore.$SGE_TASK_ID.log >>exp/tri3/decode_test/log/acoustic_rescore.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/decode_test/log/acoustic_rescore.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3/decode_test/log/acoustic_rescore.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/decode_test/q/sync/done.4238.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/decode_test/q/acoustic_rescore.log -l sgpu -P parole    -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/decode_test/q/acoustic_rescore.sh >>exp/tri3/decode_test/q/acoustic_rescore.log 2>&1
