#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --write-occs=exp/tri2/20.occs --mix-up=11500 --power=0.25 exp/tri2/19.mdl "gmm-sum-accs - exp/tri2/19.*.acc |" exp/tri2/20.mdl 
EOF
) >exp/tri2/log/update.19.log
time1=`date +"%s"`
 ( gmm-est --write-occs=exp/tri2/20.occs --mix-up=11500 --power=0.25 exp/tri2/19.mdl "gmm-sum-accs - exp/tri2/19.*.acc |" exp/tri2/20.mdl  ) 2>>exp/tri2/log/update.19.log >>exp/tri2/log/update.19.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/log/update.19.log
echo '#' Finished at `date` with status $ret >>exp/tri2/log/update.19.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/q/sync/done.2776
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/q/update.19.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/q/update.19.sh >>exp/tri2/q/update.19.log 2>&1
