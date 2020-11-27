## SRA-Toolkit

Bits and pieces for downloading read files from the [Sequence Read Archive](https://www.ncbi.nlm.nih.gov/sra)

This script uses software developed by the [SRA](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software) contained within a Singularity container.

The singularity recipe is provided; the user must have root privileges on the local machine to build the singularity image.

The shell script by default reads a text file containing SRA accession IDs, or alternatively a single ID can be specified on the command line. 

The path to where the Singularity image has been built should be specified in the shell script before use.

### Script usage - Flags

-a   |   Specify a single accession to download. The accession ID must be provided on the command line with the flag.  
-o   |   Specify the path to the desired output folder.  
-p   |   Specify that the fastq files are paired-end and should be split. This is the default option.  
-s   |   Specify that the fastq files are single-end.  
-f   |   Force the overwrite of any existing files with the same title.
