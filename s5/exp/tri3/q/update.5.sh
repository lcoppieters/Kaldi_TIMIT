#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --power=0.2 --write-occs=exp/tri3/6.occs --mix-up=4500 exp/tri3/5.mdl "gmm-sum-accs - exp/tri3/5.*.acc |" exp/tri3/6.mdl 
EOF
) >exp/tri3/log/update.5.log
time1=`date +"%s"`
 ( gmm-est --power=0.2 --write-occs=exp/tri3/6.occs --mix-up=4500 exp/tri3/5.mdl "gmm-sum-accs - exp/tri3/5.*.acc |" exp/tri3/6.mdl  ) 2>>exp/tri3/log/update.5.log >>exp/tri3/log/update.5.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/update.5.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/update.5.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.17716
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/update.5.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/update.5.sh >>exp/tri3/q/update.5.log 2>&1
