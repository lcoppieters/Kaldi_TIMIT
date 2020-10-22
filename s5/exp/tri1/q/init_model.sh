#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
gmm-init-model --write-occs=exp/tri1/1.occs exp/tri1/tree exp/tri1/treeacc data/lang/topo exp/tri1/1.mdl 
EOF
) >exp/tri1/log/init_model.log
time1=`date +"%s"`
 ( gmm-init-model --write-occs=exp/tri1/1.occs exp/tri1/tree exp/tri1/treeacc data/lang/topo exp/tri1/1.mdl  ) 2>>exp/tri1/log/init_model.log >>exp/tri1/log/init_model.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri1/log/init_model.log
echo '#' Finished at `date` with status $ret >>exp/tri1/log/init_model.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri1/q/sync/done.8853
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri1/q/init_model.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri1/q/init_model.sh >>exp/tri1/q/init_model.log 2>&1
