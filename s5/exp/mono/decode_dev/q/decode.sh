#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-latgen-faster --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=exp/mono/graph/words.txt exp/mono/final.mdl exp/mono/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk scp:data/dev/split5/${SGE_TASK_ID}/cmvn.scp scp:data/dev/split5/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark:|gzip -c > exp/mono/decode_dev/lat.${SGE_TASK_ID}.gz" 
EOF
) >exp/mono/decode_dev/log/decode.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-latgen-faster --max-active=7000 --beam=13.0 --lattice-beam=6.0 --acoustic-scale=0.083333 --allow-partial=true --word-symbol-table=exp/mono/graph/words.txt exp/mono/final.mdl exp/mono/graph/HCLG.fst "ark,s,cs:apply-cmvn  --utt2spk=ark:data/dev/split5/${SGE_TASK_ID}/utt2spk scp:data/dev/split5/${SGE_TASK_ID}/cmvn.scp scp:data/dev/split5/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark:|gzip -c > exp/mono/decode_dev/lat.${SGE_TASK_ID}.gz"  ) 2>>exp/mono/decode_dev/log/decode.$SGE_TASK_ID.log >>exp/mono/decode_dev/log/decode.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/decode_dev/log/decode.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/mono/decode_dev/log/decode.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/decode_dev/q/sync/done.18904.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/decode_dev/q/decode.log -l q1d -P parole    -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/decode_dev/q/decode.sh >>exp/mono/decode_dev/q/decode.log 2>&1
