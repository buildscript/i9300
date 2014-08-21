#!/bin/bash
 
cd ~/du
 
# Turn off break on error to allow build process to run
set +e
 
############################################################
# BUILD ROM                                                #
############################################################
 
# Turn on compiler caching
export USE_CCACHE=1

# Set the OFFICIAL build flag
export DU_BUILD_TYPE=OFFICIAL

# Set the prebuilt chromium flag
export USE_PREBUILT_CHROMIUM=1
 
# Start build process
cd ~/du && . build/envsetup.sh && time brunch i9300
 
############################################################
# COPY ROM TO FTP SERVER			                       #
############################################################
 
set -e

echo "Do you want to upload it to i9300/Official?"

read -p "(y/n)" -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    . ~/du/i9300_up_official.sh    
fi
 
# Notify user of success 
beep -f 784 -r 3 -l 100
sleep .1
beep -f 784 -l 600
beep -f 622 -l 600
beep -f 698 -l 600
beep -f 784 -l 200
sleep .2
beep -f 698 -l 200
beep -f 784 -l 800

echo 'Build completed successfully!'

############################################################
# CLOBBER                			                       #
############################################################

echo "Do you want to clobber $OUT?"

read -p "(y/n)" -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    . ~/du/clobber.sh    
fi