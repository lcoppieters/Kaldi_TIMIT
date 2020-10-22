#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --mix-up=15000 --power=0.25 --write-occs=exp/tri1/28.occs exp/tri1/27.mdl "gmm-sum-accs - exp/tri1/27.*.acc |" exp/tri1/28.mdl 
EOF
) >exp/tri1/log/update.27.log
time1=`date +"%s"`
 ( gmm-est --mix-up=15000 --power=0.25 --write-occs=exp/tri1/28.occs exp/tri1/27.mdl "gmm-sum-accs - exp/tri1/27.*.acc |" exp/tri1/28.mdl  ) 2>>exp/tri1/log/update.27.log >>exp/tri1/log/update.27.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/log/update.27.log
echo '#' Finished at `date` with status $ret >>exp/tri1/log/update.27.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/q/sync/done.17731
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/q/update.27.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/q/update.27.sh >>exp/tri1/q/update.27.log 2>&1
