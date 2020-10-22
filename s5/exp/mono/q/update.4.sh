#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --write-occs=exp/mono/5.occs --mix-up=228 --power=0.25 exp/mono/4.mdl "gmm-sum-accs - exp/mono/4.*.acc|" exp/mono/5.mdl 
EOF
) >exp/mono/log/update.4.log
time1=`date +"%s"`
 ( gmm-est --write-occs=exp/mono/5.occs --mix-up=228 --power=0.25 exp/mono/4.mdl "gmm-sum-accs - exp/mono/4.*.acc|" exp/mono/5.mdl  ) 2>>exp/mono/log/update.4.log >>exp/mono/log/update.4.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/mono/log/update.4.log
echo '#' Finished at `date` with status $ret >>exp/mono/log/update.4.log
[ $ret -eq 137 ] && exit 100;
touch exp/mono/q/sync/done.21642
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/mono/q/update.4.log -l q1d -P parole    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/mono/q/update.4.sh >>exp/mono/q/update.4.log 2>&1