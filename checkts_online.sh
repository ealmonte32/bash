#!/bin/bash
# ealmonte
# check if TS is online

# clean up logs
rm -f ./ts_online.log; rm -f ./ts_offline.log;

TS_ARRAY=(rm101-ts rm103-ts rm105-ts rm106-ts rm107-ts rm110-ts \
rm201-ts rm202-ts rm203-ts rm204-ts rm205-ts rm206-ts rm207-ts \
rm300-ts rm301-ts rm302-ts rm303-ts rm304-ts rm305-ts rm307-ts rm309-ts rm311-ts rm312-ts rm313-ts rm314-ts \
rm320a-ts rm320b-ts rm321a-ts rm321b-ts rm322-ts rm323-ts rm324a-ts rm328-ts rm330-ts rm332-ts \
rm400-ts rm401-ts rm402-ts rm403-ts rm404-ts rm405-ts rm406-ts rm407-ts \
rm500-ts rm501-ts rm502-ts rm503-ts rm504-ts rm506-ts \
rm601-ts rm602-ts rm603-ts rm604-ts rm605-ts rm606-ts)

echo -n "Scanning"
for i in "${TS_ARRAY[@]}"; do #for every item in the array
echo -n "." #show progress
ping -t 2 -c 1 $i >/dev/null 2>&1;
if [ $? != 0 ] #if exit status is not 0 it means no response
then echo $i >> ./ts_offline.log;
else echo $i >> ./ts_online.log;
fi
done

echo "============================="
echo "These hosts are online:"
cat ./ts_online.log
echo "============================="
echo "These hosts are offline:"
cat ./ts_offline.log
echo "============================="

#end
