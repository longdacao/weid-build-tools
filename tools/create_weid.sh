#!/bin/bash

cd ..
source ./script/common.inc

cd ${SOURCE_CODE_DIR}

build_classpath

echo "begin to create weidentity did, please wait..."
java -cp "$CLASSPATH" com.webank.weid.command.CreateWeId

if [ ! $? -eq 0 ]; then
    echo "Create weid faild, please check the log -> ../logs/error.log."
    exit $?;
fi

 if [ ! -d ${SOURCE_CODE_DIR}/output/create_weid ];then
        
        mkdir -p ${SOURCE_CODE_DIR}/output/create_weid
fi

if [ -f "weid" ];then
    weid=$(cat weid)
    OLD_IFS="$IFS"
    IFS=":"
    array=($weid)
    IFS="$OLD_IFS"
    weid_address=${array[3]}
    mkdir -p ${SOURCE_CODE_DIR}/output/create_weid/${weid_address}
    mv ecdsa_key.pub ${SOURCE_CODE_DIR}/output/create_weid/${weid_address}/
    mv ecdsa_key ${SOURCE_CODE_DIR}/output/create_weid/${weid_address}/
    mv weid ${SOURCE_CODE_DIR}/output/create_weid/${weid_address}/
fi

echo "new weidentity did has been created, the related data can be found at ${SOURCE_CODE_DIR}/output/create_weid/${weid_address}."
