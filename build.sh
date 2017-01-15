#!/bin/bash
# Tupin build script

#################################################
 
BUILD_PATH=".build"
SOURCE_PATH="src"
LIB_PATH="lib"
TEST_PATH="test" 
SAMPLE_CODE="sample/code"
ARTIFACT_FOLDER="lib/artifact"

INPUT_FILE=""
OUTPUT_FILE=""
PROGRAM_FILE="$BUILD_PATH/Program.exe"

#################################################
 
function help
{
    echo "Tupin builder options:"
    echo "  -h | help     Shows this message."
    echo "  -r | run      Opens the program after compiling."
    echo "  -t | test     Runs tests after compiling."
    echo "  -i            Input file"
    echo "  -o            Output file"
    echo "  artifacts     Build artifacts.h file"
}

function compile
{
    if [ -d "$BUILD_PATH" ]; then
        echo "Removing old build path..."
        rm -rf "$BUILD_PATH/"
    fi
 
    echo "Copying libraries..."
    mkdir "$BUILD_PATH/"
    cp -a "$SOURCE_PATH/." "$BUILD_PATH/" 
    cp -a "$LIB_PATH/." "$BUILD_PATH/" 

    LEXCPP="$BUILD_PATH/Lexer.cpp"
    YACCPP="$BUILD_PATH/Parser.cpp"

    echo "Generating lex artifacts..."
    flex -o$LEXCPP "$BUILD_PATH/Lexer.l"

    echo "Generating yacc artifacts..."  
    bison "$BUILD_PATH/Parser.y" -do $YACCPP

    if [ -f $YACCPP ]; then
        if [ -f $LEXCPP ]; then
                echo "Compiling C++ file..."
                g++ -std=gnu++14 -o $PROGRAM_FILE $LEXCPP $YACCPP
        else
            echo "~ERROR: $LEXCPP not found.";
        fi
    else 
        echo "~ERROR: $YACCPP not found.";
    fi
    
    echo "------------------- DONE ------------------------"
}

function attachParam
{
    # attach input and output to params
    if [ -f "$INPUT_FILE" ]; then
        PARAMS="$PARAMS $INPUT_FILE"
    fi 
    if [ -f "$OUTPUT_FILE" ]; then
        PARAMS="$PARAMS $OUTPUT_FILE"
    fi
}

function run
{   
    if [ ! -f $PROGRAM_FILE ]; then
        echo "No program file."
        exit 1
    fi  
    
    PARAMS="./$PROGRAM_FILE $INPUT_FILE $OUTPUT_FILE"

    echo "Starting program..."
    echo "$PARAMS"
    echo "-------------------------------------------------"    
    $PARAMS
}

function test 
{       
    test="$BUILD_PATH/test"
    echo "Test output folder: $test"  
    mkdir $test

    # all .tpn files
    echo "Starting test..."
    for file in $SAMPLE_CODE/*.tpn ; do  
        if [ -f $file ]; then   
            echo "-----------------------------------------"         
            echo "Running $file..."
            out=${file##*/}
            out="$test/${out%.*}.cpp"   
            ./$PROGRAM_FILE $file $out            
        fi
    done    

    echo "-----------------------------------------"         
    echo "ALL TESTS COMPLETED."
    exit
}

function OLD_TEST 
{
    echo "Copying test libraries..."
    cp -a "$TEST_PATH/." "$BUILD_PATH"

    echo "Compiling tests..."
    g++ -rdynamic -std=gnu++14 -o "$BUILD_PATH/Test.exe" "$BUILD_PATH/Test.cpp"

    PARAMS="$BUILD_PATH/Test.exe"
    if [! -f  $PARAMS ]; then
        echo "No program file."
        exit 1
    fi 

    PARAMS="./$PARAMS $INPUT_FILE $OUTPUT_FILE"

    echo "Running tests..."
    echo "$PARAMS"
    echo "-------------------------------------------------"    
    attachParam
    $PARAMS
}

function iterateFolder
{ 
    # first visit subfolders
    for dir in $1/** ; do   
        if [ -d $dir ]; then 
            iterateFolder $dir $2 $3
        fi
    done

    #echo $1 
        
    rel="${1#$3/}" 
    echo "// -- $rel -- " >> $2 

    # top level files 
    for file in $1/*.h ; do  
        if [ -f $file ]; then   
            echo "#include \"${file#$3/}\"" >> $2
        fi
    done    
    
    echo >> $2
}

function buildArtifacts
{   
    file="$LIB_PATH/artifacts.h"
    echo "Building $file..."

    echo "/*" > $file
    echo " * Auto generated artifact file" >> $file
    echo " * $(date)" >> $file
    echo " */" >> $file
    echo >> $file
    
    iterateFolder "$ARTIFACT_FOLDER" "$file" "$LIB_PATH"
    
    echo "DONE."    
}

#################################################
    
RUN_TASK=0
TEST_TASK=0

while [ "$1" != "" ]; do
    case $1 in         
        -t | test )             TEST_TASK=1 
                                ;;                                
        -r | run )              RUN_TASK=1 
                                ;;
        -i )                    shift
                                INPUT_FILE=$1
                                ;;
        -o )                    shift
                                OUTPUT_FILE=$1
                                ;;
        -h | --help | help )    help
                                exit
                                ;;
        artifacts )             buildArtifacts
                                exit
                                ;;
        * )                     help
                                exit 1 
    esac
    shift
done

# RUN TASKS AT LAST
#buildArtifacts
compile
if [ $TEST_TASK == 1 ]; then 
    test
fi 
if [ $RUN_TASK == 1 ]; then 
    run
fi