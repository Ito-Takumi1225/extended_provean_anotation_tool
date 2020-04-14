if [ -f $2/db/$1.fasta ]; then
    :
else
    echo  '>tmp' > $2/db/$1.fasta
    java -jar $3 show -nodownload $4 $1|grep Protein|tail -n -1|cut -f 4|sed 's/\?/X/g'|sed 's/\*/X/g' >> $2/db/$1.fasta
fi 

cat $2/db/$1.fasta|tail -n 1
