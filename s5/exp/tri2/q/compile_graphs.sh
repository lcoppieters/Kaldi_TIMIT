#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
compile-train-graphs --read-disambig-syms=data/lang/phones/disambig.int exp/tri2/tree exp/tri2/1.mdl data/lang/L.fst "ark:utils/sym2int.pl --map-oov 38 -f 2- data/lang/words.txt < data/train/split30/${SGE_TASK_ID}/text |" "ark:|gzip -c >exp/tri2/fsts.${SGE_TASK_ID}.gz" 
EOF
) >exp/tri2/log/compile_graphs.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( compile-train-graphs --read-disambig-syms=data/lang/phones/disambig.int exp/tri2/tree exp/tri2/1.mdl data/lang/L.fst "ark:utils/sym2int.pl --map-oov 38 -f 2- data/lang/words.txt < data/train/split30/${SGE_TASK_ID}/text |" "ark:|gzip -c >exp/tri2/fsts.${SGE_TASK_ID}.gz"  ) 2>>exp/tri2/log/compile_graphs.$SGE_TASK_ID.log >>exp/tri2/log/compile_graphs.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/log/compile_graphs.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri2/log/compile_graphs.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/q/sync/done.28516.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/q/compile_graphs.log -l q1d -P parole -l 'buster'   -t 1:30 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/q/compile_graphs.sh >>exp/tri2/q/compile_graphs.log 2>&1
