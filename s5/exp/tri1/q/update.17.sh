#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --mix-up=10500 --power=0.25 --write-occs=exp/tri1/18.occs exp/tri1/17.mdl "gmm-sum-accs - exp/tri1/17.*.acc |" exp/tri1/18.mdl 
EOF
) >exp/tri1/log/update.17.log
time1=`date +"%s"`
 ( gmm-est --mix-up=10500 --power=0.25 --write-occs=exp/tri1/18.occs exp/tri1/17.mdl "gmm-sum-accs - exp/tri1/17.*.acc |" exp/tri1/18.mdl  ) 2>>exp/tri1/log/update.17.log >>exp/tri1/log/update.17.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/log/update.17.log
echo '#' Finished at `date` with status $ret >>exp/tri1/log/update.17.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/q/sync/done.14399
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/q/update.17.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/q/update.17.sh >>exp/tri1/q/update.17.log 2>&1
