#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --write-occs=exp/tri2/17.occs --mix-up=10000 --power=0.25 exp/tri2/16.mdl "gmm-sum-accs - exp/tri2/16.*.acc |" exp/tri2/17.mdl 
EOF
) >exp/tri2/log/update.16.log
time1=`date +"%s"`
 ( gmm-est --write-occs=exp/tri2/17.occs --mix-up=10000 --power=0.25 exp/tri2/16.mdl "gmm-sum-accs - exp/tri2/16.*.acc |" exp/tri2/17.mdl  ) 2>>exp/tri2/log/update.16.log >>exp/tri2/log/update.16.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/log/update.16.log
echo '#' Finished at `date` with status $ret >>exp/tri2/log/update.16.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/q/sync/done.1841
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/q/update.16.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/q/update.16.sh >>exp/tri2/q/update.16.log 2>&1
