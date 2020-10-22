#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
steps/nnet/train.sh --feature-transform exp/dnn4_pretrain-dbn/final.feature_transform --dbn exp/dnn4_pretrain-dbn/6.dbn --hid-layers 0 --learn-rate 0.008 data-fmllr-tri3/train_tr90 data-fmllr-tri3/train_cv10 data/lang exp/tri3_ali exp/tri3_ali exp/dnn4_pretrain-dbn_dnn 
EOF
) >exp/dnn4_pretrain-dbn_dnn/log/train_nnet.log
time1=`date +"%s"`
 ( steps/nnet/train.sh --feature-transform exp/dnn4_pretrain-dbn/final.feature_transform --dbn exp/dnn4_pretrain-dbn/6.dbn --hid-layers 0 --learn-rate 0.008 data-fmllr-tri3/train_tr90 data-fmllr-tri3/train_cv10 data/lang exp/tri3_ali exp/tri3_ali exp/dnn4_pretrain-dbn_dnn  ) 2>>exp/dnn4_pretrain-dbn_dnn/log/train_nnet.log >>exp/dnn4_pretrain-dbn_dnn/log/train_nnet.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/dnn4_pretrain-dbn_dnn/log/train_nnet.log
echo '#' Finished at `date` with status $ret >>exp/dnn4_pretrain-dbn_dnn/log/train_nnet.log
[ $ret -eq 137 ] && exit 100;
touch exp/dnn4_pretrain-dbn_dnn/q/sync/done.19946
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/dnn4_pretrain-dbn_dnn/q/train_nnet.log -l sgpu -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/dnn4_pretrain-dbn_dnn/q/train_nnet.sh >>exp/dnn4_pretrain-dbn_dnn/q/train_nnet.log 2>&1
