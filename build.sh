#!/bin/bash
# Tupin build script

#################################################
 
BUILD_PATH=".build"
SOURCE_PATH="src"
LIB_PATH="lib"
TEST_PATH="test"

ARTIFACT_FILE="lib/artifacts.h"
ARTIFACT_FOLDER="lib/artifact"

PARAMS=""
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
                g++ -std=gnu++11 -o $PROGRAM_FILE $LEXCPP $YACCPP
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
    PARAMS="./$PROGRAM_FILE"    
    if [ ! -f $PARAMS ]; then
        echo "No program file."
        exit 1
    fi  

    echo "Starting program..."
    echo "$PARAMS"
    echo "-------------------------------------------------"    
    attachParam
    $PARAMS
}

function test 
{ 
    echo "Copying test libraries..."
    cp -a "$TEST_PATH/." "$BUILD_PATH"

    echo "Compiling tests..."
    g++ -rdynamic -std=gnu++11 -o "$BUILD_PATH/Test.exe" "$BUILD_PATH/Test.cpp"

    PARAMS="$BUILD_PATH/Test.exe"
    if [! -f  $PARAMS ]; then
        echo "No program file."
        exit 1
    fi 

    echo "Running tests..."
    echo "$PARAMS"
    echo "-------------------------------------------------"    
    attachParam
    $PARAMS
}

function artifacts
{
    cd $ARTIFACT_FOLDER

    # Top level files
    pad=0
    for file in *.h ; do 
        if [ -f $file ]; then            
            echo "#include \"$file\""    
            pad=1    
        fi
    done    
    if [ $pad == 1 ]; then
        echo 
    fi

    # Other files recursively 
    for dir in ** ; do 
        pad=0
        for file in "$dir"/*.h; do
            if [ -f $file ]; then
                echo "#include \"$file\""        
                pad=1
            fi
        done
        if [ $pad == 1 ]; then
            echo
        fi
    done

    echo
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
        artifacts )             echo "Gathering artifacts files..."
                                artifacts > "$ARTIFACT_FILE"
                                echo "$ARTIFACT_FILE updated."
                                exit
                                ;;
        * )                     help
                                exit 1 
    esac
    shift
done

# RUN TASKS AT LAST
compile
if [ $RUN_TASK == 1 ]; then 
    run
elif [ $TEST_TASK == 1 ]; then 
    test
fi 