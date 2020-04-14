#!/bin/bash
#!/usr/bin/bash

script_dir=`dirname $0`
current_dir=`pwd`

CMDNAME=`basename $0`

usage_exit() {
    echo "Usage: $CMDNAME [-i path to vcf file] [-d path to workdir] [-s path to snpEff.jar] [-r refname] [-p path to provean.sh]"
    exit 1
}

while getopts :i:d:s:r:p:h OPT
do
    case $OPT in
        i)  VALUE_I=$OPTARG
            ;;
        d)  VALUE_D=$OPTARG
            ;;
        s)  VALUE_S=$OPTARG
            ;;
        r)  VALUE_R=$OPTARG
            ;;
        p)  VALUE_P=$OPTARG
            ;;
        h)  usage_exit
            ;;        
        \?) echo "What is -$OPTARG option?"
            usage_exit        
            ;;
        :)  echo  "Option -$OPTARG requires an argument !!!"
            ;;
        
    esac
done

if [ -n "${VALUE_I}" ] ; then
    if [ -n "${VALUE_D}" ] ; then
        if [ -n "${VALUE_S}" ] ; then
            if [ -n "${VALUE_R}" ] ; then
                if [ -n "${VALUE_P}" ] ; then
                    if [ -e ${VALUE_D} ]; then
                        if [ -e ${VALUE_I} ]; then
                            if [ -e ${VALUE_S} ]; then
                                if [ -e ${VALUE_P} ]; then
                                    mkdir -p ${VALUE_D}/db
                                    mkdir -p ${VALUE_D}/output
                                    vcf_name=`basename ${VALUE_I}`
                                    cat ${VALUE_I} |sed '1,5d' |head -n 1 > ${VALUE_D}/db/tmp_${vcf_name}
                                    cat ${VALUE_I} |grep HIGH >> ${VALUE_D}/db/tmp_${vcf_name}
                                    cat ${VALUE_I} |grep MODERATE >> ${VALUE_D}/db/tmp_${vcf_name}
                                    python ${script_dir}/excel_convert_tool.py ${VALUE_D}/db/tmp_${vcf_name} ${vcf_name} ${VALUE_D}
                                    for Inputfile in `ls ${VALUE_D}/db/*xlsx` ; do python ${script_dir}/provean_score.py ${Inputfile} ${VALUE_D} ${VALUE_S} ${VALUE_R} ${VALUE_P} ${script_dir} ; done
                                    rm ${VALUE_D}/db/*xlsx
                                else 
                                    echo "Error: ${VALUE_P} not found"
                                fi
                            else
                                echo "Error: ${VALUE_S} not found"
                            fi
                        else
                            echo "Error: ${VALUE_I} not found"
                        fi
                    else
                        echo "Error: ${VALUE_D} not found"
                    fi
                else
                    echo "Error:No path to provean.sh "
                fi
            else
                echo "Error:No reference name"
            fi
        else
            echo "Error:No path to snpEff.jar "
        fi
    else
        echo "Error:No path to work directory "
    fi
else
    echo "Error:No path to input file  "
fi