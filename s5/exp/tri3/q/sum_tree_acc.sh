#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
sum-tree-stats exp/tri3/treeacc exp/tri3/1.treeacc exp/tri3/10.treeacc exp/tri3/11.treeacc exp/tri3/12.treeacc exp/tri3/13.treeacc exp/tri3/14.treeacc exp/tri3/15.treeacc exp/tri3/16.treeacc exp/tri3/17.treeacc exp/tri3/18.treeacc exp/tri3/19.treeacc exp/tri3/2.treeacc exp/tri3/20.treeacc exp/tri3/21.treeacc exp/tri3/22.treeacc exp/tri3/23.treeacc exp/tri3/24.treeacc exp/tri3/25.treeacc exp/tri3/26.treeacc exp/tri3/27.treeacc exp/tri3/28.treeacc exp/tri3/29.treeacc exp/tri3/3.treeacc exp/tri3/30.treeacc exp/tri3/4.treeacc exp/tri3/5.treeacc exp/tri3/6.treeacc exp/tri3/7.treeacc exp/tri3/8.treeacc exp/tri3/9.treeacc 
EOF
) >exp/tri3/log/sum_tree_acc.log
time1=`date +"%s"`
 ( sum-tree-stats exp/tri3/treeacc exp/tri3/1.treeacc exp/tri3/10.treeacc exp/tri3/11.treeacc exp/tri3/12.treeacc exp/tri3/13.treeacc exp/tri3/14.treeacc exp/tri3/15.treeacc exp/tri3/16.treeacc exp/tri3/17.treeacc exp/tri3/18.treeacc exp/tri3/19.treeacc exp/tri3/2.treeacc exp/tri3/20.treeacc exp/tri3/21.treeacc exp/tri3/22.treeacc exp/tri3/23.treeacc exp/tri3/24.treeacc exp/tri3/25.treeacc exp/tri3/26.treeacc exp/tri3/27.treeacc exp/tri3/28.treeacc exp/tri3/29.treeacc exp/tri3/3.treeacc exp/tri3/30.treeacc exp/tri3/4.treeacc exp/tri3/5.treeacc exp/tri3/6.treeacc exp/tri3/7.treeacc exp/tri3/8.treeacc exp/tri3/9.treeacc  ) 2>>exp/tri3/log/sum_tree_acc.log >>exp/tri3/log/sum_tree_acc.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri3/log/sum_tree_acc.log
echo '#' Finished at `date` with status $ret >>exp/tri3/log/sum_tree_acc.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri3/q/sync/done.11186
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri3/q/sum_tree_acc.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri3/q/sum_tree_acc.sh >>exp/tri3/q/sum_tree_acc.log 2>&1
