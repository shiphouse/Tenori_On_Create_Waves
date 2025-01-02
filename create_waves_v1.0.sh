#!/bin/bash

TENORI_DIR='tenori_samples'

echo 'sox script to create samples for yamaha tenori-on for different scales'

if [ $# -lt 1 ]; then   
    echo usage: create_waves.sh filename.wav
    exit
fi

#sox your_440Hz_music_file.wav your_432Hz_music_file.wav pitch +100
#sox your_440Hz_music_file.wav your_432Hz_music_file.wav pitch -31
#100 per cents
FILE_NAME=$1

INPUT_NOTE=$(basename $1 | rev | cut -f1 -d "_" | cut -f2 -d "." | rev)
echo $INPUT_NOTE

REMOVE_INPUT_NOTE=$(basename $1 | rev | cut -f1 -d "_" | rev)
BASE_FILE=$(basename -s _$REMOVE_INPUT_NOTE $1)

# creates specific samples directory
if [ ! -f ./$BASE_FILE ]; then
    mkdir ./$BASE_FILE
fi

createDir() {
    if [ ! -f ./${BASE_FILE}/${BASE_FILE}_$1 ]; then
	mkdir ./${BASE_FILE}/${BASE_FILE}_$1
    fi
}


#C3  -1200
#Db3 -1100
#D3  -1000
#Eb3 -900
#E3  -800
#F3  -700
#F#3 -600
#Gb3 -600
#G3  -500
#Ab3 -400
#A3  -300
#Bb3 -200
#B3  -100
#C4  0
#Db4 100
#D4  200
#Eb4 300
#E4  400
#F4  500
#Fs4 600
#Gb4 600
#G4  700
#Ab4 800
#A4  900
#Bb4 1000
#B4  1100
#C5  1200
#Db5 1300
#D5  1400
#E5  1600
#F5  1700
#G5  1900
#B5  2300
#C6  2400



#C3  0
#Db3 100
#D3  200
#Eb3 300
#E3  400
#F3  500
#Fs3 600
#Gb3 600
#G3  700
#Ab3 800
#A3  900
#Bb3 1000
#B3  1100
#C4  1200
#Db4 1300
#D4  1400
#Eb4 1500
#E4  1600
#F4  1700
#Fs4 1800
#Gb4 1800
#G4  1900
#Ab4 2000
#A4  2100
#Bb4 2200
#B4  2300
#C5  2400
#Db5 2500
#D5  2600
#E5  2800
#F5  2900
#G5  3100
#B5  3500
#C6  3600




NOTELIST=(C3 Db3 D3 Eb3 E3 F3 F#3 Gb3 G3 Ab3 A3 Bb3 B3 C4 Db4 D4 Eb4 E4 F4 F#4 Gb4 G4 Ab4 A4 Bb4 B4 C5 Db5 D5 E5 F5 G5 B5 C6)
#FREQOFFSET=(0 100 200 300 400 500 600 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1800 1900 2000 2100 2200 2300 2400 2500 2600 2800 2900 3100 3500 3600)
#FREQOFFSET=(-1200 -1100 -1000 -900 -800 -700 -600 -600 -500 -400 -300 -200 -100 +0 +100 +200 +300 +400 +500 +600 +600 +700 +800 +900 +1000 +1100 +1200 +1300 +1400 +1600 +1700 +1900 +2300 +2400)
FREQOFFSET=(-1200 -1100 -1000 -900 -800 -700 -600 -600 -500 -400 -300 -200 -100 +0 +100 +200 +300 +400 +500 +600 +600 +700 +800 +900 +1000 +1100 +1200 +1300 +1400 +1600 +1700 +1900 +2300 +2400)

#
IONIAN_01=(C3 D3 E3 F3 G3 A3 B3 C4 D4 E4 F4 G4 A4 B4 C5 D5)
DORIAN_02=(C3 D3 Eb3 F3 G3 A3 Bb3 C4 Db4 Eb4 F4 G4 Ab4 Bb4 C5 Db5)
PHRYGIAN_03=(C3 Db3 Eb3 F3 G3 Ab3 Bb3 C4 Db4 Eb4 F4 G4 Ab4 Bb4 C5 Db5) 
LYDIAN_04=(C3 D3 E3 F#3 G3 A3 B3 C4 D4 E4 F#4 G4 A4 B4 C5 D5)
MIXOLYDIAN_05=(C3 D3 E3 F3 G3 A3 Bb3 C4 D4 E4 F4 G4 A4 Bb4 C5 D5)
AEOLIAN_06=(C3 D3 Eb3 F3 Gb3 Ab3 Bb3 C4 Db4 Eb4 F4 Gb4 Ab4 Bb4 C5 D5)
LOCRIAN_07=(C3 Db3 Eb3 F3 Gb3 Ab3 Bb3 C4 Db4 Eb4 F4 Gb4 Ab4 Bb4 C5 Db5)
CHROMATIC_08=(C3 Db3 D3 Eb3 E3 F3 Gb3 G3 Ab3 A3 Bb3 B3 C4 Db4 D4 Eb4)
OKINAWA_09=(C3 E3 F3 G3 B3 C4 E4 F4 G4 B4 C5 E5 F5 G5 B5 C6)

#C4
DISTANCE_C_NOTES=(G Ab A Bb B C Db D Eb E F Gb)


#cambiar #->s para los nombres ficheros NO revisar, entrada solo usa b
#hasta gb3 -> prioridad 4 agudos
#G3  -500
#Ab3 -400
#A3  -300
#Bb3 -200
#B3  -100
#C4  +0
#Db4 +100
#D4  +200
#Eb4 +300
#E4  +400
#F4  +500
#Gb4 +600
DISTANCE_C_FREQ=(+500 +400 +300 +200 +100 +0 -100 -200 -300 -400 -500 -600)

findPitchCOffset() {    
    local i
    local e=${1}
    local RESULT=0
    local COUNTER=0
    
    for i in "${DISTANCE_C_NOTES[@]}";
    do
	echo $e $i
	if [ “$e” == “$i” ] && [ $RESULT == 0 ]; then
	    RESULT="${DISTANCE_C_FREQ[COUNTER]}"
	fi
	((COUNTER=COUNTER+1))
    done
    PITCH_C_OFFSET=$RESULT
    return $RESULT;
}

containsNote () {
    local i
    local e=${1}
    RESULT=255
    COUNTER=0
    #echo $e
    #echo “${@:2}”
    for i in ${@:2};
    do
	#echo $e $i
	if [ “$e” == “$i” ] && [ $RESULT == 255 ]; then
	    #RESULT="${FREQOFFSET[COUNTER]}"
	    RESULT=$COUNTER
	fi
	((COUNTER=COUNTER+1))
    done
    return $RESULT;
}

containsScale() {
    local COUNTER_=1
    local COUNTER_PITCH=0
    local i
    local SOX_PITCH=0
    local RESULT
    for i in "${NOTELIST[@]}";
    do
	#containsNote $i ${IONIAN_01[@]}
	containsNote $i ${@}
	RESULT="$?"
	if [ $RESULT -ne 255 ]; then 
	    printf -v COUNTER_P "%02d" "$COUNTER_"
	    SOX_PITCH=$(("${FREQOFFSET[COUNTER_PITCH]}" + "$PITCH_C_OFFSET"))
	    echo ${BASE_FILE}/${BASE_FILE}_$1/${BASE_FILE}_${COUNTER_P}_${i}.wav pitch percent $SOX_PITCH
	    if [ "${FREQOFFSET[COUNTER_PITCH]}" -eq +0 ]; then
		echo cp $FILE_NAME ${BASE_FILE}/${BASE_FILE}_$1/${BASE_FILE}_${COUNTER_P}_${i}.wav
		cp $FILE_NAME ${BASE_FILE}/${BASE_FILE}_$1/${BASE_FILE}_${COUNTER_P}_${i}.wav
	    else
		sox $FILE_NAME ${BASE_FILE}/${BASE_FILE}_$1/${BASE_FILE}_${COUNTER_P}_${i}.wav pitch $SOX_PITCH
		echo sox $FILE_NAME ${BASE_FILE}/${BASE_FILE}_$1/${BASE_FILE}_${COUNTER_P}_${i}.wav pitch $SOX_PITCH
	    fi
	    ((COUNTER_=COUNTER_+1))
	fi;
	COUNTER_PITCH=$[$COUNTER_PITCH +1]
    done
}

findPitchCOffset $INPUT_NOTE
echo $PITCH_C_OFFSET

createDir 01_ionian
createDir 02_dorian
createDir 03_phryan
createDir 04_lydian
createDir 05_mixolydian
createDir 06_aeolian
createDir 07_locrian
createDir 08_chromatic
createDir 09_okinawa

containsScale 01_ionian ${IONIAN_01[@]}  
containsScale 02_dorian ${DORIAN_02[@]}  
containsScale 03_phryan ${PHRYGIAN_03[@]} 
containsScale 04_lydian ${LYDIAN_04[@]} 
containsScale 05_mixolydian ${MIXOLYDIAN_05[@]} 
containsScale 06_aeolian ${AEOLIAN_06[@]} 
containsScale 07_locrian ${LOCRIAN_07[@]}
containsScale 08_chromatic ${CHROMATIC_08[@]}
containsScale 09_okinawa ${OKINAWA_09[@]}

# 01_ionian IONIAN 
#C3 D3  E3  F3  G3  A3  B3  C4 D4  E4  F4  G4  A4  B4  C5 D5
# 02_dorian DORIAN 
#C3 D3  Eb3 F3  G3  A3  Bb3 C4 Db4 Eb4 F4  G4  Ab4 Bb4 C5 Db5
# 03_phrygian PHRYGIAN 
#C3 Db3 Eb3 F3  G3  Ab3 Bb3 C4 Db4 Eb4 F4  G4  Ab4 Bb4 C5 Db5 
# 04_lydian LYDIAN 
#C3 D3  E3  F#3 G3  A3  B3  C4 D4  E4  F#4 G4  A4  B4  C5 D5
# 05_mixolydian MIXOLIYDIAN 
#C3 D3  E3  F3  G3  A3 Bb3 C4 D4  E4  F4  G4  A4  Bb4 C5 D5 
# 06_aeolian AEOLIAN 
#C3 D3  Eb3 F3  Gb3 Ab3 Bb3 C4 Db4 Eb4 F4  Gb4 Ab4 Bb4 C5 D5
# 07_locrian LOCRIAN 
#C3 Db3 Eb3 F3  Gb3 Ab3 Bb3 C4 Db4 Eb4 F4  Gb4 Ab4 Bb4 C5 Db5
# 08_chromatic CHROMATIC 
#C3 Db3 D3  Eb3 E3  F3  Gb3 G3 Ab3 A3  Bb3 B3  C4  Db4 D4 Eb4
# 09_okinawa OKINAWA 
#C3 E3  F3  G3  B3  C4  E4  F4 G4  B4  C5  E5  F5  G5  B5 C6
