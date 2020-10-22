#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
copy-feats 'ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split10/${SGE_TASK_ID}/utt2spk scp:data/test/split10/${SGE_TASK_ID}/cmvn.scp scp:data/test/split10/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/test/split10/${SGE_TASK_ID}/utt2spk "ark:cat exp/tri3/decode_test/trans.* |" ark:- ark:- |' ark,scp:/idiap/user/lcoppieters/kaldi/egs/timit/s5/data-fmllr-tri3/test/data/feats_fmllr_test.${SGE_TASK_ID}.ark,/idiap/user/lcoppieters/kaldi/egs/timit/s5/data-fmllr-tri3/test/data/feats_fmllr_test.${SGE_TASK_ID}.scp 
EOF
) >data-fmllr-tri3/test/log/make_fmllr_feats.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( copy-feats 'ark,s,cs:apply-cmvn  --utt2spk=ark:data/test/split10/${SGE_TASK_ID}/utt2spk scp:data/test/split10/${SGE_TASK_ID}/cmvn.scp scp:data/test/split10/${SGE_TASK_ID}/feats.scp ark:- | splice-feats --left-context=3 --right-context=3 ark:- ark:- | transform-feats exp/tri3/final.mat ark:- ark:- | transform-feats --utt2spk=ark:data/test/split10/${SGE_TASK_ID}/utt2spk "ark:cat exp/tri3/decode_test/trans.* |" ark:- ark:- |' ark,scp:/idiap/user/lcoppieters/kaldi/egs/timit/s5/data-fmllr-tri3/test/data/feats_fmllr_test.${SGE_TASK_ID}.ark,/idiap/user/lcoppieters/kaldi/egs/timit/s5/data-fmllr-tri3/test/data/feats_fmllr_test.${SGE_TASK_ID}.scp  ) 2>>data-fmllr-tri3/test/log/make_fmllr_feats.$SGE_TASK_ID.log >>data-fmllr-tri3/test/log/make_fmllr_feats.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>data-fmllr-tri3/test/log/make_fmllr_feats.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>data-fmllr-tri3/test/log/make_fmllr_feats.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch data-fmllr-tri3/test/q/sync/done.6943.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o data-fmllr-tri3/test/q/make_fmllr_feats.log -l sgpu -P parole -l 'buster'   -t 1:10 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/data-fmllr-tri3/test/q/make_fmllr_feats.sh >>data-fmllr-tri3/test/q/make_fmllr_feats.log 2>&1
