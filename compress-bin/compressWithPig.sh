#!/bin/bash

check_usage() {
  if [ $# -lt 3 ]
  then
    echo "Usage:"
    echo "$0 <hdfs_input_path> <hdfs_compressed_out_path> <compression_codec:BZip2|Gzip|Snappy|etc.>"
    exit 1
  fi
}

check_usage $*
BASEDIR=$(dirname $0)
echo "compression codec=org.apache.hadoop.io.compress.$3Codec"
pig	-Dmapred.map.tasks.speculative.execution="true" \
	-Dmapred.min.split.size=2147483648 \
	-Dmapred.max.split.size=2147483648 \
	-Dmapred.output.compress="true" \
	-Dmapred.output.compression.codec="org.apache.hadoop.io.compress.$3Codec" \
	-Dmapred.reduce.tasks.speculative.execution="true" \
	-param INPUT_DIR=$1 \
	-param OUTPUT_DIR=$2 \
	-file $BASEDIR/store.pig

exit 0

