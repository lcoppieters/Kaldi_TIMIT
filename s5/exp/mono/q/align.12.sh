#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.0 1 exp/mono/12.mdl - |" "ark:gunzip -c exp/mono/fsts.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,t:|gzip -c >exp/mono/ali.${SGE_TASK_ID}.gz" 
EOF
) >exp/mono/log/align.12.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.0 1 exp/mono/12.mdl - |" "ark:gunzip -c exp/mono/fsts.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | add-deltas  ark:- ark:- |" "ark,t:|gzip -c >exp/mono/ali.${SGE_TASK_ID}.gz"  ) 2>>exp/mono/log/align.12.$SGE_TASK_ID.log >>exp/mono/log/align.12.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/log/align.12.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/mono/log/align.12.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/q/sync/done.23156.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/q/align.12.log -l q1d -P parole   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/q/align.12.sh >>exp/mono/q/align.12.log 2>&1
