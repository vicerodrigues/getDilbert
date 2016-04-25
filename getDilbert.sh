#!/bin/bash

###Dilbert no ano de 1989!###

###Data da primeira tira do Dilbert: 1989-04-16###

if [ $# -gt 1 ]

then

    echo 'Somente 1 parâmetro é aceito'
    exit 1

else

    YEAR=$1

fi


NYEAR=$(( $YEAR + 1 ))

cd ~/Comics/Dilbert/
mkdir "Dilbert-$YEAR"
cd "Dilbert-$YEAR"

if [ "$YEAR" == 1989 ]
then
    DATE=1989-04-16
elif [ "$YEAR" -gt 1989 ]
then
    DATE="$YEAR-01-01"
else
    echo '
Ano inválido: Deve ser maior que 1989.
'
    exit 1
fi

#DATE=1989-04-16

while [ "$DATE" != "$NYEAR-01-01" ]; do
    echo "Downloading Dilbert comic Strip for $DATE
"
    wget $(wget --quiet http://dilbert.com/strip/$DATE && cat $DATE|grep img-responsive|awk '{print $10}' FS='"') -O "$DATE.gif"
    DATE=$(date -I -d "$DATE 12:00 + 1 day")
    echo "
********** FINISHED $DATE **********
"
done

echo "Removendo arquivos html
"

find ./ -type f -not -regex '.*\.gif' -exec rm {} \;
