#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
sum-tree-stats exp/tri2/treeacc exp/tri2/1.treeacc exp/tri2/10.treeacc exp/tri2/11.treeacc exp/tri2/12.treeacc exp/tri2/13.treeacc exp/tri2/14.treeacc exp/tri2/15.treeacc exp/tri2/16.treeacc exp/tri2/17.treeacc exp/tri2/18.treeacc exp/tri2/19.treeacc exp/tri2/2.treeacc exp/tri2/20.treeacc exp/tri2/21.treeacc exp/tri2/22.treeacc exp/tri2/23.treeacc exp/tri2/24.treeacc exp/tri2/25.treeacc exp/tri2/26.treeacc exp/tri2/27.treeacc exp/tri2/28.treeacc exp/tri2/29.treeacc exp/tri2/3.treeacc exp/tri2/30.treeacc exp/tri2/4.treeacc exp/tri2/5.treeacc exp/tri2/6.treeacc exp/tri2/7.treeacc exp/tri2/8.treeacc exp/tri2/9.treeacc 
EOF
) >exp/tri2/log/sum_tree_acc.log
time1=`date +"%s"`
 ( sum-tree-stats exp/tri2/treeacc exp/tri2/1.treeacc exp/tri2/10.treeacc exp/tri2/11.treeacc exp/tri2/12.treeacc exp/tri2/13.treeacc exp/tri2/14.treeacc exp/tri2/15.treeacc exp/tri2/16.treeacc exp/tri2/17.treeacc exp/tri2/18.treeacc exp/tri2/19.treeacc exp/tri2/2.treeacc exp/tri2/20.treeacc exp/tri2/21.treeacc exp/tri2/22.treeacc exp/tri2/23.treeacc exp/tri2/24.treeacc exp/tri2/25.treeacc exp/tri2/26.treeacc exp/tri2/27.treeacc exp/tri2/28.treeacc exp/tri2/29.treeacc exp/tri2/3.treeacc exp/tri2/30.treeacc exp/tri2/4.treeacc exp/tri2/5.treeacc exp/tri2/6.treeacc exp/tri2/7.treeacc exp/tri2/8.treeacc exp/tri2/9.treeacc  ) 2>>exp/tri2/log/sum_tree_acc.log >>exp/tri2/log/sum_tree_acc.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/log/sum_tree_acc.log
echo '#' Finished at `date` with status $ret >>exp/tri2/log/sum_tree_acc.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/q/sync/done.28036
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/q/sum_tree_acc.log -l q1d -P parole -l 'buster'    /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/q/sum_tree_acc.sh >>exp/tri2/q/sum_tree_acc.log 2>&1
