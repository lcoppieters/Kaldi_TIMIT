#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --power=0.2 --write-occs=exp/tri3/21.occs --mix-up=12000 exp/tri3/20.mdl "gmm-sum-accs - exp/tri3/20.*.acc |" exp/tri3/21.mdl 
EOF
) >exp/tri3/log/update.20.log
time1=`date +"%s"`
 ( gmm-est --power=0.2 --write-occs=exp/tri3/21.occs --mix-up=12000 exp/tri3/20.mdl "gmm-sum-accs - exp/tri3/20.*.acc |" exp/tri3/21.mdl  ) 2>>exp/tri3/log/update.20.log >>exp/tri3/log/update.20.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/update.20.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/update.20.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.23295
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/update.20.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/update.20.sh >>exp/tri3/q/update.20.log 2>&1
