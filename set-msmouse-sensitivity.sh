#!/bin/bash

readonly DEVICE_NAME="Microsoft Microsoft® Nano Transceiver v2.0"
readonly PROP_NAME="libinput Accel Speed"
readonly PROP_VALUE="0.8"

ids=$(xinput --list | awk -v search="$DEVICE_NAME" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
    if xinput set-prop $i "$PROP_NAME" "$PROP_VALUE" > /dev/null 2>&1 ; then
        echo "Success: Set $PROP_NAME for device $i" 
    else
        echo "Failure: Set $PROP_NAME for device $i" 
    fi
done
