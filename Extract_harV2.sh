#!/bin/bash
###############################################################################################
# Input
  Var=psfc
  csv="/mnt/d/har/location_aws_AK.csv"
  in_file="/mnt/d/har/hourly_harv2/har.nc"
  out_file="/mnt/d/har/hourly_harv2/"${Var}_new.csv
#Choose interpolation method:
#'bil': bilinear
#'nn': nearest neighbour
#'bic': bicubic
  Method="nn"
################################################################################################

# read the csv file and extract the lon and lat
  declare -a Lon
  declare -a Lat
  declare -a coord
  lon=$(awk -F "\"*,\"*" '{print $4}' ${csv}) # 4th column in the csv contains longitude information
  lat=$(awk -F "\"*,\"*" '{print $5}' ${csv}) # 5th column in the csv contains latitude information

  Lon=($lon)
  Lat=($lat)


      echo "-----Run "${Run}"-----"
      for (( i=0; i<${#Lon[@]}; i++ ))
        do
            coord[i]="lon="${Lon[i]}"/lat="${Lat[i]}
      done

      for (( i=0; i<${#coord[@]}; i++ ))
        do
          COOR=${coord[i]}
          if [ ${Method} == "bil" ]
            then
  	      cdo remapbil,${COOR} -selname,${Var} ${in_file} inter
          elif [ ${Method} == "nn" ]
            then
  	      cdo remapnn,${COOR} -selname,${Var} ${in_file} inter
          elif [ ${Method} == "bic" ]
            then
	      cdo remapbic,${COOR} -selname,${Var} ${in_file} inter
          fi
          cdo info inter | grep -v time | awk '{ print $9 }' | sed -e 's/:/,/g' >> liste3.txt
          paste  liste3.txt >> sta_${i}.txt
          rm liste3.txt
      done
      cdo info  inter | grep -v time| \
      awk '{ print $3 }' | sed -e 's/-/,/g' >> liste1.txt
      paste -d , liste1.txt $(ls -v sta_*) > ${out_file}
      rm  inter  liste* sta*

  echo "-----Hooray!!!-----"
