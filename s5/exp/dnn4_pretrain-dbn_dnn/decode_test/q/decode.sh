#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
nnet-forward --no-softmax=true --prior-scale=1.0 --feature-transform=exp/dnn4_pretrain-dbn_dnn/final.feature_transform --class-frame-counts=exp/dnn4_pretrain-dbn_dnn/ali_train_pdf.counts --use-gpu=no exp/dnn4_pretrain-dbn_dnn/final.nnet "ark,s,cs:copy-feats scp:data-fmllr-tri3/test/split20/${SGE_TASK_ID}/feats.scp ark:- |" ark:- | latgen-faster-mapped --min-active=200 --max-active=7000 --max-mem=50000000 --beam=13.0 --lattice-beam=8.0 --acoustic-scale=0.2 --allow-partial=true --word-symbol-table=exp/tri3/graph/words.txt exp/dnn4_pretrain-dbn_dnn/final.mdl exp/tri3/graph/HCLG.fst ark:- "ark:|gzip -c > exp/dnn4_pretrain-dbn_dnn/decode_test/lat.${SGE_TASK_ID}.gz" 
EOF
) >exp/dnn4_pretrain-dbn_dnn/decode_test/log/decode.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( nnet-forward --no-softmax=true --prior-scale=1.0 --feature-transform=exp/dnn4_pretrain-dbn_dnn/final.feature_transform --class-frame-counts=exp/dnn4_pretrain-dbn_dnn/ali_train_pdf.counts --use-gpu=no exp/dnn4_pretrain-dbn_dnn/final.nnet "ark,s,cs:copy-feats scp:data-fmllr-tri3/test/split20/${SGE_TASK_ID}/feats.scp ark:- |" ark:- | latgen-faster-mapped --min-active=200 --max-active=7000 --max-mem=50000000 --beam=13.0 --lattice-beam=8.0 --acoustic-scale=0.2 --allow-partial=true --word-symbol-table=exp/tri3/graph/words.txt exp/dnn4_pretrain-dbn_dnn/final.mdl exp/tri3/graph/HCLG.fst ark:- "ark:|gzip -c > exp/dnn4_pretrain-dbn_dnn/decode_test/lat.${SGE_TASK_ID}.gz"  ) 2>>exp/dnn4_pretrain-dbn_dnn/decode_test/log/decode.$SGE_TASK_ID.log >>exp/dnn4_pretrain-dbn_dnn/decode_test/log/decode.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/dnn4_pretrain-dbn_dnn/decode_test/log/decode.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/dnn4_pretrain-dbn_dnn/decode_test/log/decode.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/dnn4_pretrain-dbn_dnn/decode_test/q/sync/done.11996.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/dnn4_pretrain-dbn_dnn/decode_test/q/decode.log -l sgpu -P parole -l buster -pe pe_mth 2   -t 1:20 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/dnn4_pretrain-dbn_dnn/decode_test/q/decode.sh >>exp/dnn4_pretrain-dbn_dnn/decode_test/q/decode.log 2>&1
