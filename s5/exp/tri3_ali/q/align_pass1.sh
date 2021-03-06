#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.0 1 exp/tri3/final.alimdl - |" "ark:gunzip -c exp/tri3_ali/fsts.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" "ark:|gzip -c >exp/tri3_ali/pre_ali.${SGE_TASK_ID}.gz" 
EOF
) >exp/tri3_ali/log/align_pass1.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( gmm-align-compiled --transition-scale=1.0 --acoustic-scale=0.1 --self-loop-scale=0.1 --beam=10 --retry-beam=40 --careful=false "gmm-boost-silence --boost=1.0 1 exp/tri3/final.alimdl - |" "ark:gunzip -c exp/tri3_ali/fsts.${SGE_TASK_ID}.gz|" "ark,s,cs:apply-cmvn  --utt2spk=ark:data/train/split30/${SGE_TASK_ID}/utt2spk scp:data/train/split30/${SGE_TASK_ID}/cmvn.scp scp:data/train/split30/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- |" "ark:|gzip -c >exp/tri3_ali/pre_ali.${SGE_TASK_ID}.gz"  ) 2>>exp/tri3_ali/log/align_pass1.$SGE_TASK_ID.log >>exp/tri3_ali/log/align_pass1.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3_ali/log/align_pass1.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri3_ali/log/align_pass1.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3_ali/q/sync/done.5547.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3_ali/q/align_pass1.log -l sgpu -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3_ali/q/align_pass1.sh >>exp/tri3_ali/q/align_pass1.log 2>&1
