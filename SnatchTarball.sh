#!/bin/bash
#--------------------------------------------------------------------------------
# This will automatically try to pull a file using rsync, it  will auto resume download if
# it fails midway.
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#Change these... (assumes you have an SSH key already configured to auto login to the server)
#--------------------------------------------------------------------------------
username=USERNAME                 #Server username
server=SERVER                     #Server Address
local_dir=~/src                   #Directory to store tarball
prefix=build_`date +_dev_%-d%b%Y` #Tarball prefix
server_dir = ~/builds             #Default location of tarball on server.

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
if [ "$1" ==  "" ]; then
   #Try pulling today's latest dev build, by default
   server_dir=$server_dir
   tarball=$server_dir/$prefix.tgz
else
   #Otherwise pull the file $1
   tarball=$1
fi

#Initialize to 1, so we enter while loop
finished=1

while [ $finished -ne 0 ]; do
   echo "Starting/Restarting download of" $tarball

   #Grab the file using rsync, -P allows you to continue a failed download
   rsync -avP --progress $username@$server:$tarball $local_dir

   #Check return status ($?) of rsync, 0 = rsync successfully completed
   let finished=`echo $?`
   echo "Returned: "$finished
   sleep 2
done

echo ""
echo "*Finished Downloading" $tarball
echo ""

echo "*Verifying Download..."

#Generate some checksums to verify file was properly pulled:
server_checksum=`ssh $username@$server "sha256sum $tarball" | awk '{ print $1 }'`

#Strip out the path if there is one...
filename=`basename $tarball`
local_checksum=`sha256sum $local_dir/$filename | awk '{ print $1 }'`

if [ "$server_checksum" == "$local_checksum" ]; then
   echo "   - Checksums match!"
else
   echo "   - Checksums do not match!"
   printf "\tServer Checksum: "; echo $server_checksum
   printf "\tLocal Checksum:  "; echo $local_checksum
fi
