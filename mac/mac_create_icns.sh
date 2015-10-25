#!/bin/bash

INPUT=$1
OUTPUT=${2:-${INPUT%.*}.icns}

if [[ -z "${INPUT}" ]]; then
  echo -e "ERROR: no input file given\n"
  echo -e "USAGE: $0 input-file\n"
  exit 1
fi

TMPDIR=$(mktemp -d iconXXXXXXXXXXXXXXXX.iconset)

for SIZE in 16 32 64 128 256 512; do
  sips -z ${SIZE} ${SIZE} "${INPUT}" --out "${TMPDIR}/icon_${SIZE}x${SIZE}.png";
done

for SIZE in 32 64 256 512; do
  sips -z ${SIZE} ${SIZE} "${INPUT}" --out "${TMPDIR}/icon_${SIZE}x${SIZE}@2x.png";
done

iconutil -c icns -o "${OUTPUT}" "${TMPDIR}"
rm -rf "${TMPDIR}"
