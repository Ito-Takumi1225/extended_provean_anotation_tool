# extended_provean_anotation_tool

Use extended_provean_anotation_tool to check how harmful each mutation is from the vcf file annotated with snpEff

・Existing providens and other tools that calculate mutation influence on biological function can't calculate frameshift or splicing variant influence.  
・I developed this tool and succeeded in calculating the damage of each mutation including frameshift and splicing variant from a vcf file annotated with snpEff.  
・Furthermore, these calculation results can be given as an Excel file.  


requirement  

・PROVEAN v.1.1.5(including NCBI BLAST, CDHIT, and nr database)  (http://provean.jcvi.org/downloads.php)  
・SnpEff  (http://snpeff.sourceforge.net/)  
・python2 or python3  
・python module(sys,subprocess.xlrd,openpyxl,os.re)  


install(linux)  
1.download "extended_provean_anotation_tool" from github  
(git clone https://github.com/Ito-Takumi1225/extended_provean_anotation_tool.git)

Usage  

・Inputfile is vcf file after SnpEff analysis  

`bash [path to extended_provean_anotation_tool dir]/script/extended_provean_score.sh  -i [path to input vcf file] -d [path to your workdir] -s [path to snpEff.jar] -r [Reference dataset name] -p [path to provean.sh]`

Ex.` bash [path to extended_provean_anotation_tool dir]/script/extended_provean_score.sh  -i  [path to extended_provean_anotation_tool dir]/example/test.1KG.ann.vcf -d  [path to extended_provean_anotation_tool dir]/example/work -s [path to snpEff.jar] -r [hg38] -p [path to provean.sh]  `

・Output file is excel file format and this output file exists in the [path to workdir]/output/  
・Outfile name is out_[input file pre-fix].xlsx  

・Values for the effect of amino acid mutations on a protein's biological function are given in the provean_score line.  
・If the value is less than -2.5, describe D. If the value is greater than -2.5, describe N in the proven_pred line.  
・If it cannot be calculated with the conventional providen, the mutation name is added after the providen_score and providen_pred.  
(ex -4.5_stopgain,D_stopgain)


LISENSE

