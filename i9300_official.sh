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
echo "Your build completed succesfully, Dirty Unicorns kicks ass!"
say "Your build completed succesfully, Dirty Unicorns kicks ass!"

ctrl+c

############################################################
# CLOBBER                			                       #
############################################################

echo "Do you want to clobber $OUT?"

read -p "(y/n)" -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    . ~/du/clobber.sh    
fi

