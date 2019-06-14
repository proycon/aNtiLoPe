Technical Details
======================

At the core, aNtiLoPe consists of various independent
[Nextflow](https://nextflow.io) pipeline scripts (the ``*.nf`` scripts). These pipeline scripts provide the logic to connect a number of inter-dependent **processes** and determines the data flow between them. Within these processes, any language may be use to define the scripts that performs the tasks (bash/python/perl/etc...). Typically, a process script invokes a single external tool.

The underlying tools that are invoked are not provided by aNtiLoPe itself,
but installation and distribution thereof is delegated to
[LaMachine](https://proycon.github.io/LaMachine), upon which aNtiLoPe
depends.

The exception to the above are some scripts (shell/perl/python/etc) that are
not otherwise distributed nor can be considered proper reusable tools out of
the scope of aNtiLoPe. These are distributed as part of aNtiLoPe in in ``scripts/``.
This is a fall-back solution that be preferably be kept to a minimum.

For linguistic annotation, the pivot format in aNtiLoPe is [FoLiA](https://proycon.github.io/folia).


Contributor Guidelines
=========================

* The aNtiLoPe codebase is maintained in git at https://github.com/proycon/aNtiLoPe
    * Never do any development outside of version control!!!
    * Pull requests welcome!! (direct push access for main project contributors)
    * the ``master`` branch corresponds to the latest development version and should serve as the basis for all development
        * do not use this branch for production, always use the latest release (LaMachine takes care of this for you automatically)
        * keep the master branch in a workable state, use separate git branches for intensive development cycles.
* For development of workflows, consult the [Nextflow Documentation](https://www.nextflow.io/docs/latest/index.html). The Nextflow scripting language is an extension of the Groovy programming language (runs on the Java VM) whose syntax has been specialized to ease the writing of computational pipelines in a declarative manner.
    * The process scripts within Nextflow pipeline scripts should typically invoke only a single external tool, or at least perform a single well-defined task (if you want to invoke a series of tools, use separate processes)
* To make additional tools available for use in aNtiLoPe, consult the documentation on [adding new software to LaMachine](https://github.com/proycon/LaMachine/blob/master/CONTRIBUTING.md), installing tools should *never* be the responsibility of the end-user and rarely that of aNtiLoPe itself.
* Report all bugs and feature requests pertaining to pipelines and webservice (or in case you simply don't know) to https://github.com/proycon/aNtiLoPe/issues
    * If it is clear that a problem is caused by an underlying tool, report it to the respective developer
        * For installation/deployment problems, use https://github.com/proycon/LaMachine
* Integration tests are defined in ``test.sh`` and will automatically be run on our continuous integration platform at
    https://travis-ci.com/proycon/aNtiLoPe after each git push.
    * If you add a feature, we strongly recommend you to add a test.
    * The coverage of the tests is currently seriously sub-optimal!!
    * Tests should be limited in scope so they can be performed quickly, often and with limited resources (no OCRing of whole books!!)
    * Tests on a lower (unit) level are the responsibility of the underlying tools, rather than aNtiLoPe

Setting up a Development Environment
---------------------------------------

* Install the *development* version of [LaMachine](https://proycon.github.io/LaMachine), in any flavour, and enable
    aNtiLoPe in the installation manifest during the bootstrap procedure (or just run ``lamachine-add antilope`` after the
    fact)
* The aNtiLoPe git repository will be cloned in ``$LM_SOURCEPATH/aNtiLoPe``. If you do not have direct push access to the
    aNtiLoPe repository,  we recommend you fork
    https://github.com/proycon/aNtiLoPe and add do a ``git remote add`` to track your own branch there.
* You can always upgrade your LaMachine environment with ``lamachine-update``, but make sure you don't have uncommitted
    changes (they will be stashed away automatically)!!
