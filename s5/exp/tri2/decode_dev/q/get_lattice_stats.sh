#!/bin/bash
cd /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
ali-to-phones --write-lengths=true exp/tri2/decode_dev/../final.mdl "ark:gunzip -c exp/tri2/decode_dev/ali_tmp.${SGE_TASK_ID}.gz|" ark,t:- | perl -ne 'chomp;s/^\S+\s*//;@a=split /\s;\s/, $_;$count{"begin ".$a[$0]."\n"}++;
  if(@a>1){$count{"end ".$a[-1]."\n"}++;}for($i=0;$i<@a;$i++){$count{"all ".$a[$i]."\n"}++;}
  END{for $k (sort keys %count){print "$count{$k} $k"}}' | gzip -c > exp/tri2/decode_dev/phone_stats.${SGE_TASK_ID}.gz 
EOF
) >exp/tri2/decode_dev/log/get_lattice_stats.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( ali-to-phones --write-lengths=true exp/tri2/decode_dev/../final.mdl "ark:gunzip -c exp/tri2/decode_dev/ali_tmp.${SGE_TASK_ID}.gz|" ark,t:- | perl -ne 'chomp;s/^\S+\s*//;@a=split /\s;\s/, $_;$count{"begin ".$a[$0]."\n"}++;
  if(@a>1){$count{"end ".$a[-1]."\n"}++;}for($i=0;$i<@a;$i++){$count{"all ".$a[$i]."\n"}++;}
  END{for $k (sort keys %count){print "$count{$k} $k"}}' | gzip -c > exp/tri2/decode_dev/phone_stats.${SGE_TASK_ID}.gz  ) 2>>exp/tri2/decode_dev/log/get_lattice_stats.$SGE_TASK_ID.log >>exp/tri2/decode_dev/log/get_lattice_stats.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/tri2/decode_dev/log/get_lattice_stats.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/tri2/decode_dev/log/get_lattice_stats.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/tri2/decode_dev/q/sync/done.10371.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/tri2/decode_dev/q/get_lattice_stats.log -l sgpu -P parole   -t 1:5 /remote/idiap.svm/user.active/lcoppieters/kaldi/egs/timit/s5/exp/tri2/decode_dev/q/get_lattice_stats.sh >>exp/tri2/decode_dev/q/get_lattice_stats.log 2>&1
