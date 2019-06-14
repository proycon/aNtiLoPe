[![Language Machines Badge](http://applejack.science.ru.nl/lamabadge.php/aNtiLoPe)](http://applejack.science.ru.nl/languagemachines/)
[![Build Status](https://travis-ci.org/LanguageMachines/aNtiLoPe.svg?branch=master)](https://travis-ci.com/proycon/aNtiLoPe)
[![Docker Pulls](https://img.shields.io/docker/pulls/proycon/lamachine.svg)](https://hub.docker.com/r/proycon/lamachine/)

# aNtiLoPe: Natural Language Processing pipelines that run!

aNtiLoPe offers various NLP workflows that build on a variety of tools.
This repository hosts the relevant workflows, powered by
[Nextflow](https://www.nextflow.io). The tools the workflows depend on are not included as-such, but aNtiLope itself and
all its dependencies are shipped as part of our [LaMachine](https://proycon.github.io/LaMachine) software distribution.

Some related but more specialised workflows are available as standalone projects:
 * [PICCL](https://github.com/LanguageMachines/PICCL) - A set of workflows for corpus building through OCR, post-correction and normalisation.
 * [Nederlab Pipeline](https://github.com/proycon/nederlab-pipeline) - Linguistic enrichment pipeline for historical dutch, as used in the Nederlab project
 * [Quoll](https://github.com/LanguageMachines/quoll/) - NLP text classification pipeline

Running these workflows, as opposed to manually invoking the underlying NLP tools that do the actual work, enables less
effort on the part of the user, and more portability and scalability, as the pipelines can be executed across multiple
computing nodes on a high performance cluster such as SGE, LSF, SLURM, PBS, HTCondor, Kubernetes and Amazon AWS.
Parallellisation is handled automatically. Consult the [Nextflow
documentation](https://www.nextflow.io/docs/latest/index.html) for details regarding this.

aNtiLoPe makes extensive use of the [FoLiA](https://proycon.github.io/folia) format, a rich XML-based format for linguistic
annotation.

**Important Note**: This is beta software still in development; for the old and deprecated version consult [this repository](https://github.com/martinreynaert/TICCL).

## Installation

aNtiLoPe is already shipped as a part of [LaMachine](https://proycon.github.io/LaMachine), you may need to explicitly add it using ``lamachine-add antilope`` if you already have a LaMachine instance running.
The workflows are invoked on the command line and end with the extension ``.nf``.

It's also possible to use [Nextflow](https://www.nextflow.io) directly and have it install and use the [Docker](https://docker.io) flavour of [LaMachine](https://proycon.github.io/LaMachine).
In this case you need to ensure to always run it with the ``-with-docker proycon/lamachine`` parameter:

    $ nextflow run proycon/aNtiLoPe -with-docker proycon/lamachine

## Workflows

 * ``tokenize.nf`` - A tokenisation workflow using the [ucto](https://LanguageMachines.github.io/ucto) tokeniser; takes either plaintext or untokenised FoLiA documents (e.g. output from ticcl), and produces tokenised FoLiA documents.
 * ``frog.nf`` - An NLP workflow for Dutch using the [frog](https://LanguageMachines.github.io/frog) tokeniser; takes either plaintext or untokenised FoLiA documents (e.g. output from ticcl), and produces linguistically enriched FoLiA documents, takes care of tokenisation as well.
 * ``foliavalidator.nf`` - A simple validation workflow to validate FoLiA documents. Uses the [FoLiA tools](https://github.com/proycon/foliatools)
 * ``foliaupgrader.nf`` - An upgrade tool to upgrade FoLiA documents to FoLiA v2. Uses the [FoLiA tools](https://github.com/proycon/foliatools)

Running with these workflows with the ``--help`` parameter or absence of any parameters will output usage
information.

## Technical Details & Contributing

Please see CONTRIBUTE.md for technical details and information on how to contribute.



















