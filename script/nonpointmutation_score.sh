if [ -f $2/db/$1.sss ]; then
  $4 -q $2/db/$1.fasta -v $2/db/$3.var --supporting_set $2/db/$1.sss|grep -v PROVEAN|grep -v VARIATION|cut -f 2
else
  $4 -q $2/db/$1.fasta -v $2/db/$3.var --save_supporting_set $2/db/$1.sss|grep -v PROVEAN|grep -v VARIATION|cut -f 2
fi

rm $2/db/$3.var