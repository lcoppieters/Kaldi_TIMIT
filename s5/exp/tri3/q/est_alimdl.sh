#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-est --power=0.2 --remove-low-count-gaussians=false exp/tri3/35.mdl "gmm-sum-accs - exp/tri3/35.*.acc|" exp/tri3/35.alimdl 
EOF
) >exp/tri3/log/est_alimdl.log
time1=`date +"%s"`
 ( gmm-est --power=0.2 --remove-low-count-gaussians=false exp/tri3/35.mdl "gmm-sum-accs - exp/tri3/35.*.acc|" exp/tri3/35.alimdl  ) 2>>exp/tri3/log/est_alimdl.log >>exp/tri3/log/est_alimdl.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/est_alimdl.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/est_alimdl.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.28159
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/est_alimdl.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/est_alimdl.sh >>exp/tri3/q/est_alimdl.log 2>&1
