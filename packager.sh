#!/bin/sh
########################################################################
#                                                                      #
# Author: Muneer Saheed <muneer@live.it>                               #
# A packager script that can create a self extracting archive file.    #
# Version: 1.0.0                                                       #
#                                                                      #
# Usage:                                                               #
# sh packager.sh docker.tgz                                            #
#                                                                      #
########################################################################
tgz=$1
[ -z "$tgz" ] && echo "No input given" && exit -1
[ ! -f "$tgz" ] && echo "Input does not match a file" && exit -1
CHARS_COUNT=$(wc -c docker.tgz | cut -d" " -f 1)
OUTPUT_FILE="installer.tgz.sh"
echo '#!/bin/sh' > $OUTPUT_FILE
echo "tail -c$CHARS_COUNT \"\$0\" > final.tgz" >> $OUTPUT_FILE
echo 'DIR_NAME=$(head -c10 /dev/urandom | base64 | head -c 10)' >> $OUTPUT_FILE
echo 'mkdir "$DIR_NAME"' >> $OUTPUT_FILE
echo 'tar -xzf final.tgz -C "$DIR_NAME"' >> $OUTPUT_FILE
echo 'rm -f final.tgz' >> $OUTPUT_FILE
echo 'echo "Extracted to directory $DIR_NAME"' >> $OUTPUT_FILE
echo 'exit 0' >> $OUTPUT_FILE
cat $tgz >> $OUTPUT_FILE
chmod +x $OUTPUT_FILE
exit 0
