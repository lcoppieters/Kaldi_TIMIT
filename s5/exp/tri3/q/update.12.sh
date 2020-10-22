#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --power=0.2 --write-occs=exp/tri3/13.occs --mix-up=8000 exp/tri3/12.mdl "gmm-sum-accs - exp/tri3/12.*.acc |" exp/tri3/13.mdl 
EOF
) >exp/tri3/log/update.12.log
time1=`date +"%s"`
 ( gmm-est --power=0.2 --write-occs=exp/tri3/13.occs --mix-up=8000 exp/tri3/12.mdl "gmm-sum-accs - exp/tri3/12.*.acc |" exp/tri3/13.mdl  ) 2>>exp/tri3/log/update.12.log >>exp/tri3/log/update.12.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/update.12.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/update.12.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.20845
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/update.12.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/update.12.sh >>exp/tri3/q/update.12.log 2>&1
