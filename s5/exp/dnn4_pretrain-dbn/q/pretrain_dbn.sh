#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
steps/nnet/pretrain_dbn.sh --hid-dim 1024 --rbm-iter 20 data-fmllr-tri3/train exp/dnn4_pretrain-dbn 
EOF
) >exp/dnn4_pretrain-dbn/log/pretrain_dbn.log
time1=`date +"%s"`
 ( steps/nnet/pretrain_dbn.sh --hid-dim 1024 --rbm-iter 20 data-fmllr-tri3/train exp/dnn4_pretrain-dbn  ) 2>>exp/dnn4_pretrain-dbn/log/pretrain_dbn.log >>exp/dnn4_pretrain-dbn/log/pretrain_dbn.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/dnn4_pretrain-dbn/log/pretrain_dbn.log
echo '#' Finished at `date` with status $ret >>exp/dnn4_pretrain-dbn/log/pretrain_dbn.log
[ $ret -eq 137 ] && exit 100;
touch exp/dnn4_pretrain-dbn/q/sync/done.7684
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/dnn4_pretrain-dbn/q/pretrain_dbn.log -l sgpu -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/dnn4_pretrain-dbn/q/pretrain_dbn.sh >>exp/dnn4_pretrain-dbn/q/pretrain_dbn.log 2>&1
