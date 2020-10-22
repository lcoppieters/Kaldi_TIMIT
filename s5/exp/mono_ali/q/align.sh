#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
compile-train-graphs --read-disambig-syms=data/lang/phones/disambig.int exp/mono_ali/tree exp/mono_ali/final.mdl data/lang/L.fst "ark:utils/sym2int.pl --map-oov 38 -f 2- data/lang/words.txt data/train/split30/${SGE_TASK_ID}/text|" ark:- | gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.25 1 exp/mono_ali/final.mdl - |" ark:- "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,t:|gzip -c >exp/mono_ali/ali.${SGE_TASK_ID}.gz" 
EOF
) >exp/mono_ali/log/align.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( compile-train-graphs --read-disambig-syms=data/lang/phones/disambig.int exp/mono_ali/tree exp/mono_ali/final.mdl data/lang/L.fst "ark:utils/sym2int.pl --map-oov 38 -f 2- data/lang/words.txt data/train/split30/${SGE_TASK_ID}/text|" ark:- | gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.25 1 exp/mono_ali/final.mdl - |" ark:- "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,t:|gzip -c >exp/mono_ali/ali.${SGE_TASK_ID}.gz"  ) 2>>exp/mono_ali/log/align.$SGE_TASK_ID.log >>exp/mono_ali/log/align.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono_ali/log/align.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/mono_ali/log/align.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono_ali/q/sync/done.26784.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono_ali/q/align.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono_ali/q/align.sh >>exp/mono_ali/q/align.log 2>&1
