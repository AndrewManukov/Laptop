#!/bin/bash

#TODO: toupper on grade #bash 3.2, easy way wont work
#TODO: automate grades? 
#TODO: on boot open terminal to flash drive directory
#TODO: update bash on all HDD. (Maybe not worth but we will see)
#TODO: Add bluetooth automation (jk prolly wont work)
#why are we erasing instead of renaming?
#TODO SHORT: combine macbook7 and 1 to macbook7.1

###################################### INITAILIZE VARIABLES ######################################

#vars for survey
lcd=""
mag=""
mic=""
speakers="" 
pad="" 
bluetooth=""
wifi=""
cam="" 
usb=""
key=""
grade=""
comment=""
skip=""

grader="Andrew"
filename="config1.csv"

#flow

#check name hdd 
#diskutil eraseDisk JHFS+ MacOS /dev/disk0 #RENAME HDD TO HIGHSIERRA 


#init variables
sn=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
modelid=$(sysctl hw.model | awk '{print $2}')
cpu=$(sysctl -n machdep.cpu.brand_string | awk '{print $3}')
ram=$(echo "scale=2; $(sysctl -n hw.memsize) / 1024^3" | bc )
hdd=$(diskutil list disk0 | grep "disk0s2" | awk '{print $4}') #MUST INIT INTERNAL DISK
hddname=$(diskutil list disk0 | grep "disk0s2" | awk '{print $3}')
cycle=$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')

#renaming hdd
#if [ "$hddname" != "HighSierra" ]
#then
#    /usr/sbin/diskutil rename $hddname HighSierra
#fi

#if [ "$hddname" != "HighSierra" ]
#then
#    sudo asr restore --source /Volumes/HighSierra --target /Volumes/$hddname --erase --noprompt
#fi

#echo hdd name and size and have user confirm.
###################################### INITAILIZE VARIABLES ######################################

#questionnaire
#todo long: create functions that do the case statement 

#check if hdd is a float

###################################### FUNCTIONALITY TESTS ######################################
while [ "$skip" = "" ] #no idea why this works...= is assignment and == is comparision usually.
do
  read -p "Do all functionality tests pass? (y/n)?: " choice
  case "$choice" in 
    y|Y ) skip="Y";;
    n|N ) skip="N";;
    * ) skip="" echo "Invalid Option";;
  esac
done

if [ "$skip" = "N" ]
then
  while [ "$lcd" = "" ] #no idea why this works...= is assignment and == is comparision usually.
  do
    read -p "Good LCD (y/n)?: " choice
    case "$choice" in 
      y|Y ) lcd="Y";;
      n|N ) lcd="N";;
      * ) lcd="" echo "Invalid Option";;
    esac
  done


  while [ "$mag" = "" ]
  do
    read -p "Good MAGSAFE (y/n)?: " choice
    case "$choice" in 
      y|Y ) mag="Y";;
      n|N ) mag="N";;
      * ) mag="" echo "Invalid Option";;
    esac
  done

  while [ "$pad" = "" ]
  do
    read -p "Good TRACKPAD (y/n)?: " choice
    case "$choice" in 
      y|Y ) pad="Y";;
      n|N ) pad="N";;
      * ) pad="" echo "Invalid Option";;
    esac
  done

  echo 'Click on Siri and ask something to check the Microphone and Speakers'
  read -n 1 -r -s -p $'Press any key to continue...\n'

  while [ "$mic" = "" ]
  do
    read -p "Good MICROPHONE (y/n)?: " choice
    case "$choice" in 
      y|Y ) mic="Y";;
      n|N ) mic="N";;
      * ) mic="" echo "Invalid Option";;
    esac
  done

  while [ "$speakers" = "" ]
  do
    read -p "Good SPEAKERS (y/n)?: " choice
    case "$choice" in 
      y|Y ) speakers="Y";;
      n|N ) speakers="N";;
      * ) speakers="" echo "Invalid Option";;
    esac
  done

  echo 'Open FaceTime App on the tool bar to check the Camera'
  read -n 1 -r -s -p $'Press enter to continue...\n'

  while [ "$cam" = "" ]
  do
    read -p "Good CAMERA (y/n)?: " choice
    case "$choice" in 
      y|Y ) cam="Y";;
      n|N ) cam="N";;
      * ) cam="" echo "Invalid Option";;
    esac
  done


  echo 'Connect to device via bluetooth using the system preferences tab'
  read -n 1 -r -s -p $'Press any key to continue...\n'


  while [ "$bluetooth" = "" ]
  do
    read -p "Good BLUETOOTH (y/n)?: " choice
    case "$choice" in 
      y|Y ) bluetooth="Y";;
      n|N ) bluetooth="N";;
      * ) bluetooth="" echo "Invalid Option";;
    esac
  done

  echo 'Make sure you are connected to the MobilityTest WIFI'
  read -n 1 -r -s -p $'Press any key to continue...\n'

  while [ "$wifi" = "" ]
  do
    read -p "Good WIFI (y/n)?: " choice
    case "$choice" in 
      y|Y ) wifi="Y";;
      n|N ) wifi="N";;
      * ) wifi="" echo "Invalid Option";;
    esac
  done

  echo 'Make sure there are no keys missing'
  read -n 1 -r -s -p $'Press any key to continue...\n'


  while [ "$key" = "" ]
  do
    read -p "Good KEYBOARD (y/n)?: " choice
    case "$choice" in 
      y|Y ) key="Y";;
      n|N ) key="N";;
      * ) key="" echo "Invalid Option";;
    esac
  done

  while [ "$usb" = "" ]
  do
    read -p "Good USB PORTS (y/n)?: " choice
    case "$choice" in 
      y|Y ) usb="Y";;
      n|N ) usb="N";;
      * ) usb="" echo "Invalid Option";;
    esac
  done
else
  lcd="Y"
  mag="Y"
  mic="Y"
  speakers="Y" 
  pad="Y" 
  bluetooth="Y"
  wifi="Y"
  cam="Y" 
  usb="Y"
  key="Y"
fi




#mdm check down here bc wifi is needed. 
mdm_dep=$(Profiles status -type enrollment | grep "DEP" | awk '{print $4}')
mdm_MDM=$(Profiles status -type enrollment | grep "MDM" | awk '{print $3}')

###################################### FUNCTIONALITY TESTS ######################################


#output

echo ---------------------------------------------- 
echo SN: $sn
echo CPU: $cpu 
echo MODEL IDENTIFIER: $modelid
echo RAM: $ram GB
echo HDD: $hdd GB
echo LCD: $lcd 
echo MAGSAFE: $mag
echo MICROPHONE: $mic
echo SPEAKERS: $speakers
echo TRACKPAD: $pad
echo BLUETOOTH: $bluetooth
echo WIFI: $wifi
echo CAMERA: $cam
echo KEYBOARD: $key
echo USB PORTS: $usb
echo POWER CYCLES: $cycle
echo ENROLLED VIA DEP: $mdm_dep
echo MDM ENROLLMENT: $mdm_MDM
echo ---------------------------------------------- 

#enter grade and comments 
#todo: create var isFailed (minus LCD)

#rework 

read -n 1 -r -s -p $'Get ready to enter grade. Press any key to continue...\n'

#read -p 'Enter Grade: ' grade


###################################### GRADE SELECTION ######################################
while [ "$grade" == "" ]
do
    read -p "Enter grade (A/B/C/D/F/S)?: " choice
    case "$choice" in 
      a|A ) grade="A";;
      b|B ) grade="B";;
      c|C ) grade="C";;
      d|D ) grade="D";;
      f|F ) grade="F";;
      s|S ) grade="S";;
      * ) grade="" echo "Invalid Option";;
  esac
done

if [ "$grade" == "F" ]
then
    echo "1) FL"
    echo "2) FD"
    echo "3) FLD"
    echo "4) FF"
    read -p "Which F? (1/2/3/4)?: " choice
    case "$choice" in 
      1 ) grade="FL";;
      2 ) grade="FD";;
      3 ) grade="FLD";;
      4 ) grade="FF";;
      * ) echo "Invalid Option";;
    esac   
fi
###################################### GRADE SELECTION ######################################


###################################### CASE STATEMENT FOR COMMENT SELECTION ######################################

echo Select your reason for grade $grade


case $grade in

  A | a)
    echo "1) No Problems"
    echo "2) 1-2 Light Scratches"
    read -p "Enter comment (1/2)?: " choice
    case "$choice" in 
      1 ) comment="No Problems";;
      2 ) comment="1-2 Light Scratches";;
      * ) comment="" echo "Invalid Option";;
    esac
    ;;

  B | b)
    echo "1) Uneven lighting on LCD"
    echo "2) Minor Pitting"
    echo "3) 2-4 Minor Scratches"
    echo "4) 1-2 Medium Scratches"  
    read -p "Enter comment (1/2/3/4)?: " choice
    case "$choice" in 
      1 ) comment="Uneven lighting on LCD";;
      2 ) comment="Minor Pitting";;
      3 ) comment="2-4 Minor Scratches";;
      4 ) comment="1-2 Medium Scratches";;
      * ) comment="" echo "Invalid Option";;
    esac
    ;;

  C | c)
    echo "1) Up to 3 White Spots or Dead Pixels"
    echo "2) Loose Hinge"
    echo "3) 4-6 Minor scratches"
    echo "4) 2-4 Medium Scratches"
    echo "5) 1-2 Heavy Scratches"  
    echo "6) Minor Dents"
    read -p "Enter comment (1/2/3/4/5/6)?: " choice
    case "$choice" in 
      1 ) comment="Up to 3 White Spots/Dead Pixels";;
      2 ) comment="Loose Hinge";;
      3 ) comment="4-6 Minor scratches";;
      4 ) comment="2-4 Medium Scratches";;
      5 ) comment="1-2 Heavy Scratches";;
      6 ) comment="Minor Dents";;
      * ) comment="" echo "Invalid Option";;
    esac
    if [ "$comment" == "Up to 3 White Spots/Dead Pixels" ]
    then
        echo "1) Nothing Else"
        echo "2) Loose Hinge"
        echo "3) Minor Scratches"
        echo "4) Medium Scratches"   
        echo "5) Minor Pitting"
        echo "6) Minor Dents"
        read -p "Enter additional comments (1/2/3/4/5/6)?: " choice
        case "$choice" in 
          1 ) comment="$comment";;
          2 ) comment="$comment/Loose Hinge";;
          3 ) comment="$comment/Minor Scratches";;
          4 ) comment="$comment/Medium Scratches";;
          5 ) comment="$comment/Minor Pitting";;
          6 ) comment="$comment/Minor Dents";;
          * ) comment="" echo "Invalid Option";;
        esac
    elif [ "$comment" == "Loose Hinge" ]
    then
        echo "1) Nothing Else"
        echo "2) Minor Scratches"
        echo "3) Medium Scratches"  
        echo "4) Minor Pitting"
        echo "5) Minor Dents"
        read -p "Enter additional comments (1/2/3/4/5)?: " choice
        case "$choice" in 
          1 ) comment="$comment";;
          2 ) comment="$comment/Minor Scratches";;
          3 ) comment="$comment/Medium Scratches";;
          4 ) comment="$comment/Minor Pitting";;
          5 ) comment="$comment/Minor Dents";;
          * ) comment="" echo "Invalid Option";;
        esac
    fi    
    ;;

  D | d)
    echo "1) 3-5 White Spots or Dead Pixels"
    echo "2) Broken Hinge"
    echo "3) Heavy Scratches"
    echo "4) Heavy Pitting"
    echo "5) Heavy Dents"  
    read -p "Enter comment (1/2/3/4/5)?: " choice
    case "$choice" in 
      1 ) comment="3-5 White Spots/Dead Pixels";;
      2 ) comment="Broken Hinge";;
      3 ) comment="Heavy Scratches";;
      4 ) comment="Heavy Pitting";;
      5 ) comment="Heavy Dents";;
      * ) comment="" echo "Invalid Option";;
    esac
    if [ "$comment" == "3-5 White Spots/Dead Pixels" ]
    then
        echo "1) Nothing Else"
        echo "2) Light Scratches"
        echo "3) Minor Scratches"
        echo "4) Medium Scratches"  
        echo "5) Heavy Scratches"  
        echo "6) Minor Pitting"
        echo "7) Heavy Pitting"
        echo "8) Minor Dents"
        echo "9) Heavy Dents"
        echo "0) Broken Hinge"
        read -p "Enter additional comments (1/2/3/4/5/6/7/8/9/0)?: " choice
        case "$choice" in 
          1 ) comment="$comment";;
          2 ) comment="$comment/Light Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
          3 ) comment="$comment/Minor Scratches";;
          4 ) comment="$comment/Medium Scratches";;
          5 ) comment="$comment/Heavy Scratches";;
          6 ) comment="$comment/Minor Pitting";;
          7 ) comment="$comment/Heavy Pitting";;
          8 ) comment="$comment/Minor Dents";;
          9 ) comment="$comment/Heavy Dents";;
          0 ) comment="$comment/Broken Hinge";;
          * ) comment="" echo "Invalid Option";;
        esac
    elif [ "$comment" == "Broken Hinge" ]
    then
        echo "1) Nothing Else"
        echo "2) Light Scratches"
        echo "3) Minor Scratches"
        echo "4) Medium Scratches"  
        echo "5) Heavy Scratches"  
        echo "6) Minor Pitting"
        echo "7) Heavy Pitting"
        echo "8) Minor Dents"
        echo "9) Heavy Dents"
        read -p "Enter additional comments (1/2/3/4/5/6/7/8/9)?: " choice
        case "$choice" in 
          1 ) comment="$comment";;
          2 ) comment="$comment/Light Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
          3 ) comment="$comment/Minor Scratches";;
          4 ) comment="$comment/Medium Scratches";;
          5 ) comment="$comment/Heavy Scratches";;
          6 ) comment="$comment/Minor Pitting";;
          7 ) comment="$comment/Heavy Pitting";;
          8 ) comment="$comment/Minor Dents";;
          9 ) comment="$comment/Heavy Dents";;
          * ) comment="" echo "Invalid Option";;
        esac
    fi    
    ;;

  FL | fl)
    echo "1) Lines present on display"
    echo "2) Bleeding and/or improperly functioning display"
    echo "3) More than 5 white spots or dead pixels"
    read -p "Enter comment (1/2/3)?: " choice
    case "$choice" in 
      1 ) comment="Lines present on display";;
      2 ) comment="Bleeding and/or improperly functioning display";;
      3 ) comment="More than 5 white spots or dead pixels";;
      * ) comment="" echo "Invalid Option";;
    esac
    echo "1) Nothing Else"
    echo "2) Scratches"
    echo "3) Dents"
    echo "4) Pitting"  
    read -p "Enter additional comments (1/2/3/4)?: " choice
    case "$choice" in 
        1 ) comment="$comment";;
        2 ) comment="$comment/Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
        3 ) comment="$comment/Dents";;
        4 ) comment="$comment/Pitting";;
        * ) comment="" echo "Invalid Option";;
    esac
    ;;

  FD | fd) #doenst mattter if i add fd bc it sets to FD auto
    echo "1) Front glass cracked"
    read -p "Enter comment (1)?: " choice
    case "$choice" in 
      1 ) comment="Front glass cracked";;
      * ) comment="" echo "Invalid Option";;
    esac
    echo "1) Nothing Else"
    echo "2) Scratches"
    echo "3) Dents"
    echo "4) Pitting"  
    read -p "Enter additional comments (1/2/3/4)?: " choice
    case "$choice" in 
        1 ) comment="$comment";;
        2 ) comment="$comment/Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
        3 ) comment="$comment/Dents";;
        4 ) comment="$comment/Pitting";;
        * ) comment="" echo "Invalid Option";;
    esac
    ;;

  FLD | fld)
    echo "1) LCD severely damaged and front glass non-functional"
    read -p "Enter comment (1)?: " choice
    case "$choice" in 
      1 ) comment="LCD severely damaged/front glass non-functional";;
      * ) comment="" echo "Invalid Option";;
    esac
    echo "1) Nothing Else"
    echo "2) Scratches"
    echo "3) Dents"
    echo "4) Pitting"  
    read -p "Enter additional comments (1/2/3/4)?: " choice
    case "$choice" in 
        1 ) comment="$comment";;
        2 ) comment="$comment/Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
        3 ) comment="$comment/Dents";;
        4 ) comment="$comment/Pitting";;
        * ) comment="" echo "Invalid Option";;
    esac
    ;;

  FF | ff)
    echo "1) Failed Functionality Tests"
    read -p "Enter comment (1)?: " choice
    case "$choice" in 
      1 ) comment="Failed Functionality Tests";;
      * ) comment="" echo "Invalid Option";;
    esac
    echo "1) Nothing Else"
    echo "2) Scratches"
    echo "3) Dents"
    echo "4) Pitting"  
    read -p "Enter additional comments (1/2/3/4)?: " choice
    case "$choice" in 
        1 ) comment="$comment";;
        2 ) comment="$comment/Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
        3 ) comment="$comment/Dents";;
        4 ) comment="$comment/Pitting";;
        * ) comment="" echo "Invalid Option";;
    esac
    ;;

  S | s)
    echo "1) Scrap or Safety Hazard"
    echo "2) Bent or Crushed or No Power or Swollen Battery"
    echo "3) NO SSD"
    read -p "Enter comment (1/2/3)?: " choice
    case "$choice" in 
      1 ) comment="Scrap or Safety Hazard";;
      2 ) comment="Bent/Crushed/NoPower/SwollenBattery";;
      3 ) comment="NO SSD";;
      * ) comment="" echo "Invalid Option";;
    esac
    echo "1) Nothing Else"
    echo "2) Scratches"
    echo "3) Dents"
    echo "4) Pitting"  
    read -p "Enter additional comments (1/2/3/4)?: " choice
    case "$choice" in 
        1 ) comment="$comment";;
        2 ) comment="$comment/Scratches";; #lightscr="Light Scratches" comment="$comment $lightscr"
        3 ) comment="$comment/Dents";;
        4 ) comment="$comment/Pitting";;
        * ) comment="" echo "Invalid Option";;
    esac
    ;;

  *)
    echo "Invalid Grade. Please press CTRL + C"
    ;;
esac


###################################### CASE STATEMENT FOR COMMENT SELECTION ######################################

###################################### PRINT RESULTS AND WRITE TO .CSV ######################################
echo ---------------------------------------------- 
echo SN: $sn
echo CPU: $cpu 
echo MODEL IDENTIFIER: $modelid
echo RAM: $ram GB
echo HDD: $hdd GB
echo LCD: $lcd 
echo MAGSAFE: $mag
echo MICROPHONE: $mic
echo SPEAKERS: $speakers
echo TRACKPAD: $pad
echo BLUETOOTH: $bluetooth
echo WIFI: $wifi
echo CAMERA: $cam
echo KEYBOARD: $key
echo USB PORTS: $usb
echo POWER CYCLES: $cycle
echo ENROLLED VIA DEP: $mdm_dep
echo MDM ENROLLMENT: $mdm_MDM
echo GRADE: $grade
echo COMMENT: $comment
echo ---------------------------------------------- 

echo 'Is this correct? If not press CTRL + C.'
read -n 1 -r -s -p $'Press any key 3 times to continue...\n'
read -n 1 -r -s -p $'Press any key 2 times to continue...\n'
read -n 1 -r -s -p $'Press any key 1 time to continue...\n' 

#check first line of csv file. add header if header isnt there

#write to file

echo $sn, $modelid, $cpu, $ram GB, $hdd GB, $lcd, $mag, $mic, $speakers, $pad, $bluetooth, $wifi, $cam, $key, $usb, $cycle, $mdm_dep, $mdm_MDM, GRADE $grade, $comment, $grader >> $filename

read -n 1 -r -s -p $'Press any key to shutdown...\n' 
sleep 5.5
sudo shutdown -h now
###################################### PRINT RESULTS AND WRITE TO .CSV FILE ######################################




