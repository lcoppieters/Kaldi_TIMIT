#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --write-occs=exp/mono/27.occs --mix-up=844 --power=0.25 exp/mono/26.mdl "gmm-sum-accs - exp/mono/26.*.acc|" exp/mono/27.mdl 
EOF
) >exp/mono/log/update.26.log
time1=`date +"%s"`
 ( gmm-est --write-occs=exp/mono/27.occs --mix-up=844 --power=0.25 exp/mono/26.mdl "gmm-sum-accs - exp/mono/26.*.acc|" exp/mono/27.mdl  ) 2>>exp/mono/log/update.26.log >>exp/mono/log/update.26.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/log/update.26.log
echo '#' Finished at `date` with status $ret >>exp/mono/log/update.26.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/q/sync/done.25473
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/q/update.26.log -l q1d -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/q/update.26.sh >>exp/mono/q/update.26.log 2>&1
