echo $4 > $2/db/$3.var

if [ -f $2/db/$1.sss ]; then
  $5 -q $2/db/$1.fasta -v $2/db/$3.var --supporting_set $2/db/$1.sss|grep -A 1 VARIATION |tail -n 1 | cut -f 2
else
  $5 -q $2/db/$1.fasta -v $2/db/$3.var --save_supporting_set $2/db/$1.sss|grep -A 1 VARIATION |tail -n 1 | cut -f 2
fi

rm $2/db/$3.var