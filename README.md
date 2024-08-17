[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[GitHub actions status](https://github.com/kenji-yt/REAP/actions/workflows/main.yml/badge.svg)

# REAP
### <ins>R</ins>eproducible <ins>E</ins>xpression <ins>A</ins>nalysis for <ins>P</ins>olyploids

REAP is an allopolyploid specific snakemake workflow for the analysis of RNAseq data. The workflow includes all basic steps in RNAseq data analysis (quality check and alignment), a read sorting tool specific for allopolyploids, differential expression analysis and a set of downstream analyses.

## Installation

To install this workflow you first need to [install Snakemake via Conda](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html). Next, run the following commands to clone the REAP repository to your computer :

```
git clone https://github.com/kenji-yt/REAP
```

## Using REAP

### 1. Set up
First, edit or create a `metadata.txt` file contain information about you samples. The format is detailed [here](https://github.com/supermaxiste/ARPEGGIO/wiki/Input-files). For an example, see `REAP/example/metadata.txt`.

Next, you need to edit the `config.yaml` file to configure your REAP analysis. This file can be found in the REAP directory.
In the config file you can specify where the output should be written, where metadata, raw data and supporting data can be found, and which steps you want the workflow to perform. A detailed tutorial can be found [here](https://github.com/supermaxiste/ARPEGGIO/wiki). 

### 2. Run

To run the workflow, simply enter the REAP directory and run the following commands:

```
snakemake --use-conda --cores N 
```

Make sure to be in the conda directory with snakemake intalled and to replace N with the number of cores you wish to allocate to snakemake. 

## Contribute
Any contribution is welcome, be it issues or pull requests (PRs). For PRs make sure your code changes pass all the necessary tests by running the following commands to check for breaking changes and make sure you're following best practices:

1) Install [`snakefmt`](https://github.com/snakemake/snakefmt) and run:

```
snakefmt workflow/Snakefile workflow/rules/*
```

2) Run the snakemake linter:

```
snakemake --lint
```


## Help
Feel free to open an issue if you have found no solution to your problem anywhere else. 
