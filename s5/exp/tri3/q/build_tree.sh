#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
build-tree --verbose=1 --max-leaves=2500 --cluster-thresh=-1 exp/tri3/treeacc data/lang/phones/roots.int exp/tri3/questions.qst data/lang/topo exp/tri3/tree 
EOF
) >exp/tri3/log/build_tree.log
time1=`date +"%s"`
 ( build-tree --verbose=1 --max-leaves=2500 --cluster-thresh=-1 exp/tri3/treeacc data/lang/phones/roots.int exp/tri3/questions.qst data/lang/topo exp/tri3/tree  ) 2>>exp/tri3/log/build_tree.log >>exp/tri3/log/build_tree.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/build_tree.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/build_tree.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.11215
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/build_tree.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/build_tree.sh >>exp/tri3/q/build_tree.log 2>&1
