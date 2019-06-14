#!/bin/bash

####################################################### INITIALISATION ##################################################

if [[ "$USER" == "travis" ]]; then
   #special handling for travis-ci
   cd /home/travis/build/proycon/aNtiLoPe
   export PATH="/home/travis/build/proycon/aNtiLoPe:$PATH"
   source lamachine-${CONF_NAME}-activate
   if [ -z "$VIRTUAL_ENV" ]; then
       echo "LaMachine did not activate properly"
       exit 2
   fi
   ls -l
fi

if ! touch .test; then #test write permission
   echo "No writing permission in current working directory"
   exit 2
fi
rm .test

ANTILOPE="nextflow run proycon/aNtiLoPe"
if [ -d /vagrant ] || [ ! -z "$LM_PREFIX" ]; then
    #we are in LaMachine, no need for docker
    WITHDOCKER=""
    BASEDIR=$(dirname "${BASH_SOURCE[0]}")
    if [ -f $BASEDIR/foliavalidator.nf ]; then
        ANTILOPE=$BASEDIR #run piccl scripts directly
        echo "ANTILOPE directory is $BASEDIR"
    fi
else
    #we are not in LaMachine so use the docker LaMachine:
    WITHDOCKER="-with-docker proycon/lamachine"
fi


checkfolia () {
    if [ -f "$1" ] && [ -s "$1" ]; then
       folialint $1 >/dev/null || exit 2
    fi
}

if [ ! -z "$1" ]; then
    TEST=$1
else
    TEST="all"
fi


#################################################### PREPARATION #######################################################

# Setting up some input texts to be used by tests

if [ ! -d text_input ]; then
    mkdir -p text_input || exit 2
    cd text_input
    #prepare a small test text:
    echo "Magnetisme is een natuurkundig verschijnsel dat zich uit in krachtwerking tussen magneten of andere gemagnetiseerde of magnetiseerbare voorwerpen, en een krachtwerking heeft op bewegende elektrische ladingen, zoals in stroomvoerende leidingen. De krachtwerking vindt plaats door middel van een magnetisch veld, dat door de voorwerpen zelf of anderszins wordt opgewekt.

Al in de Oudheid ontdekte men dat magnetietkristallen magnetisch zijn. Magnetiet is, evenals magnesium genoemd naar Magnesia, een gebied in Thessalië in het oude Griekenland. Verantwoordelijk voor het magnetisme van magnetiet is het aanwezige ijzer. Veel ijzerlegeringen vertonen magnetisme. Naast ijzer vertonen ook nikkel, kobalt en gadolinium magnetische eigenschappen.

Er zijn natuurlijke en kunstmatige magneten (bijvoorbeeld Alnico, Fernico, ferrieten). Alle magneten hebben twee polen die de noordpool en de zuidpool worden genoemd. De noordpool van een magneet stoot de noordpool van een andere magneet af, en trekt de zuidpool van een andere magneet aan. Twee zuidpolen stoten elkaar ook af. Omdat ook de aarde een magneetveld heeft, met z'n magnetische zuidpool vlak bij de geografische noordpool en z'n magnetische noordpool vlak bij de geografische zuidpool, zal een vrij ronddraaiende magneet altijd de noord-zuidrichting aannemen. De benamingen van de polen van een magneet zijn hiervan afgeleid. Overigens wordt gemakshalve, maar wel enigszins verwarrend, de zuidpool van de \"aardemagneet\" de magnetische noordpool genoemd en de noordpool van de \"aardemagneet\" de magnetische zuidpool. Dit is iets waar zelden bij stilgestaan wordt, maar de noordpool van een kompasnaald wijst immers naar het noorden, dus wordt deze aangetrokken door wat feitelijk een magnetische zuidpool is.

Een verwant verschijnsel is elektromagnetisme, magnetisme dat ontstaat door een elektrische stroom. In wezen wordt alle magnetisme veroorzaakt door zowel roterende als revolverende elektrische ladingen in kringstromen." > magnetisme.txt    #source: https://nl.wikipedia.org/wiki/Magnetisme
    cd ..
fi


###################################################### TESTS ###########################################################

if [[ "$TEST" == "toktxt" ]] || [[ "$TEST" == "all" ]]; then
    echo -e "\n\n======== Testing tokenisation pipeline from plain text ========= ">&2
    if [ -d tokenized_output ]; then rm -Rf tokenized_output; fi  #cleanup previous results if they're still lingering around
    $ANTILOPE/tokenize.nf --inputdir text_input --inputformat text --language nld $WITHDOCKER || exit 2
    checkfolia tokenized_output/magnetisme.tok.folia.xml
fi

if [[ "$TEST" == "frogtxt" ]] || [[ "$TEST" == "all" ]]; then
    echo -e "\n\n========= Testing frog pipeline from plain text ========= ">&2
    if [ -d frog_output ]; then rm -Rf frog_output; fi  #cleanup previous results if they're still lingering around
    $ANTILOPE/frog.nf --inputdir text_input --inputformat text --language nld $WITHDOCKER || exit 2
    checkfolia frog_output/magnetisme.frogged.folia.xml
fi

