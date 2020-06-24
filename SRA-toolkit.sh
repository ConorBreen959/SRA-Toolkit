#! /bin/bash
set -e
set -u
set -o pipefail

avalue=
pvalue=
gvalue=
ovalue=

while getopts ':p?g?a:o:' OPTION; do
	case "$OPTION" in
		a)
		  avalue="$OPTARG"
		  ;;
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
			[-a] | Specify a single accesion ID to read
		  	[-p] | Specifies paired-end reads and splits into two fastq files.
		  	[-g] | Specifies whether to gzip the download.
		  	[-o] | Provide the path to the download directory" >&2
		  exit 1
		  ;;
	esac
done


shift "$((OPTIND -1))"

if [[ -z "$avalue" ]]; then
  echo "Reading accession file"
  while IFS= read -r line
  do
    echo "Reading accession $line . . ."
    singularity exec /home/conor/Documents/Software/SRA_toolkit/SRA_toolkit.simg fastq-dump $pvalue $gvalue $ovalue "$line"
    echo "Done"
  done < "$1"
else
  echo "Using single accession"
  singularity exec /home/conor/Documents/Software/SRA_toolkit/SRA_toolkit.simg fastq-dump $pvalue $gvalue $ovalue $avalue
  echo "Done"
fi
