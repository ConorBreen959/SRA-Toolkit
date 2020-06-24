#! /bin/bash
set -e
set -u
set -o pipefail

pvalue=
gvalue=
ovalue=

while getopts ':p?g?a:o:' OPTION; do
	case "$OPTION" in
		p)
		  pvalue='--split-files'
		  ;;
		g)
	 	  gvalue='--gzip'
		  ;;
		o)
		  ovalue="-O $OPTARG"
		  ;;
		?)
		  echo "script usage: $(basename $0)
		  	[-p] | Specifies paired-end reads and splits into two fastq files.
		  	[-g] | Specifies whether to gzip the download.
		  	[-o] | Provide the path to the download directory" >&2
		  exit 1
		  ;;
	esac
done


shift "$((OPTIND -1))"

while IFS= read -r line
do
  echo "Reading accession $line . . ."
  singularity exec /SRA_toolkit/SRA_toolkit.simg fastq-dump $pvalue $gvalue $ovalue "$line"
  echo "Done"
done < "$1"