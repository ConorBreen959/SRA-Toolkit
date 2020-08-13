#! /bin/bash
set -e
set -u
set -o pipefail

## Open flag variables

avalue=
ovalue=
pvalue=
svalue=
fvalue=

## Getopts set up of optional flags

while getopts ':p?s?f?a:o:' OPTION; do
	case "$OPTION" in
		a)
		  avalue="$OPTARG"
		  ;;
		o)
		  ovalue="-O $OPTARG"
		  ;;
		p)
		  pvalue="--split-reads"
		  ;;
		s)
		  svalue="--concatenate-reads"
		  ;;
		f)
		  fvalue="--force"
		  ;;
		?)
		  echo "Script usage: SRA-toolkit
			[-a] | Specify a single accesion ID to read instead of an accession file
		  	[-o] | Provide the path to the desired output directory
		  	[-p] | Specify paired-end reads (default)
			[-s] | Specify single-end reads
		  	[-f] | Force overwrite of existing files" >&2
		  exit 1
		  ;;
	esac
done


shift "$((OPTIND -1))"

## Check if -a flag has been called to download single accession
if [[ -n "$avalue" ]]; then

  ## Print output folder if specified
  if [[ -n "$ovalue" ]]; then
  	echo "Output path $ovalue"
  fi
  echo "Using single accession"

  ## Call singularity image to download single accession
  singularity exec /home/conor/Documents/Software/SRA_toolkit/sra-toolkit.simg fasterq-dump $fvalue $pvalue $svalue $ovalue $avalue
  echo "Done"

else

  ## Print output folder if specified
  if [[ -n "$ovalue" ]]; then
  	echo "Output path $ovalue"
  fi
  echo "Reading accession file"

  ## While loop to read accession file
  while IFS= read -r line
  do
    echo "Reading accession $line . . ."

    ## Call singularity image to download each accession in the accession file
    singularity exec /home/conor/Documents/Software/SRA_toolkit/sra-toolkit.simg fasterq-dump $fvalue $pvalue $svalue $ovalue "$line"
    echo "Done"
  done < "$1"  

fi
