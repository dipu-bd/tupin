#!/bin/bash
# Tupin build script

#################################################
 
BUILD_PATH=".build"
SOURCE_PATH="src"
LIB_PATH="$SOURCE_PATH/lib"
TEST_PATH="$SOURCE_PATH/test"
PROGRAM_FILE="$BUILD_PATH/Program.exe"
PARAMS=""
INPUT_FILE=""
OUTPUT_FILE=""

#################################################

noecho
 
function compile
{
    if [ -d "$BUILD_PATH" ]; then
        echo "Removing old build path..."
        rm -rf "$BUILD_PATH/"
    fi

    echo "Creating build path..."
    mkdir "$BUILD_PATH/"

    echo "Copying libraries..."
    cp -R "$LIB_PATH/" "$BUILD_PATH/"

    echo "Generating lex artifacts..."
    flex -o"$BUILD_PATH/Lexer.cpp" "$SOURCE_PATH/Lexer.l"

    echo "Generating yacc artifacts..."  
    bison "$SOURCE_PATH/Parser.y" -do "$BUILD_PATH/Parser.cpp"  

    if [ -f "$BUILD_PATH/Lexer.cpp" ]; then
        if [ -f "$BUILD_PATH/Parser.cpp" ]; then
            echo "Compiling C++ file..."
            g++ -std=gnu++11 -o "$PROGRAM_FILE" "$BUILD_PATH/Lexer.cpp" "$BUILD_PATH/Parser.cpp" 
        else 
            echo "~ERROR: Parser.cpp not found.";
        fi
    else
        echo "~ERROR: Lexer.cpp not found.";
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
    echo "Compiling tests..."
    g++ -rdynamic -std=gnu++11 -o "$BUILD_PATH/Test.exe" "$TEST_PATH/Test.cpp"

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

function help
{
    echo "Tupin builder options:"
    echo "  -h | help     Shows this message."
    echo "  -r | run      Opens the program after compiling."
    echo "  -t | test     Runs tests after compiling."
    echo "  -i            Input file"
    echo "  -o            Output file"
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