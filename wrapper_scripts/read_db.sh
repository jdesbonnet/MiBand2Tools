#!/bin/bash

# Input: database file name + output file name
# Example: ./read_db 1 1

DB=$1
OUTPUT=$2
DATEXTENSION='.dat'
DBEXTENSION='.db'

echo 'Checking formats...'

if [[ ${OUTPUT} = *".dat" ]]
then
	echo 'Found .dat file'
	echo ${OUTPUT}
else
	OUTPUT=${OUTPUT}${DATEXTENSION}
	echo ${OUTPUT}
fi

if [[ ${DB} = *'.db' ]]
then
	echo 'Found .db file'
	echo ${DB}
else
	DB=${DB}${DBEXTENSION}
	echo ${DB}
fi

../scripts/read_gadgetbridge_db.sh ../../databases/${DB} >> ../../data/${OUTPUT}