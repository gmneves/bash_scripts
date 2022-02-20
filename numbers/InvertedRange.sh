#!/bin/bash

FILE=${1}
SIZE=${2}
BREAK=${3}
ORIGINAL=()
INVERTED=()
INDEX=0

if [ "$FILE" == "" ]; then
  echo "Informar um arquivo"
  exit 1
fi

if [ "${SIZE}" == "" ]; then
  echo "Tamanho vazio, assumindo 100"
  SIZE=100
fi

while read -r NUMBER; do
  ORIGINAL[${INDEX}]=${NUMBER}
  INDEX=$((INDEX+1))
done<"${FILE}"

for i in $(seq 1 "${SIZE}"); do
  if [[ ! " ${ORIGINAL[*]} " =~ " ${i} " ]]; then
    INVERTED[((${#INVERTED[@]}+1))]=${i}
  fi
done

LAST=0
SKIP=0
for i in $(seq 1 $((${#INVERTED[@]}))); do
  if [ "${i}" -eq "1" ];then
    LIST=${INVERTED[1]}
  fi
  PLUS_ONE=$((${INVERTED[$i]} + 1))
  NEXT_ELEMENT=${INVERTED[$((i+1))]}
  if [ ! "${NEXT_ELEMENT}" == "" ] && [ "${PLUS_ONE}" -eq "${NEXT_ELEMENT}" ];then
    if [ "$LAST" -eq "0" ]; then
      if [ "${LIST: -2}" != "; " ];  then
        LIST="${LIST}-"
        LAST=1
        SKIP=0
        continue
      else
        LIST="${LIST}${INVERTED[$i]}"
        continue
      fi
    fi
  else
    if [ "${SKIP}" -ne "1" ];then
      if [ "${i}" -eq "1" ]; then
        LIST="${LIST}; "
        continue
      else
        if [ "${LIST: -1}" != "-" ] && [ "${LIST: -1}" != " " ]; then
          LIST="${LIST}-"
        fi
        LIST="${LIST}${INVERTED[$i]}; " 
        SKIP=1
        LAST=0
        continue
      fi
    fi

    if [ "${LIST: -1}" != "-" ] && [ "${LIST: -1}" != " " ]; then
      LIST="${LIST}-"
  fi
      LIST="${LIST}${INVERTED[$i]}; "
    SKIP=0
    LAST=0
  fi
done

if [ "${BREAK}" == "y" ];then
  echo "${LIST}" | sed -E -e 's/;(\s)?/\n/g' | sed -e '/^$/d'
elif [ "${BREAK}" == "s" ];then
  echo "${LIST}" | sed -E -e 's/;(\s)?/;/g' 
else
  echo "${LIST}"
fi

