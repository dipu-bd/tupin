#!/bin/bash
# Tupin build script

#################################################
 
BUILD_PATH=".build"
SOURCE_PATH="src"
LIB_PATH="$SOURCE_PATH/lib"
TEST_PATH="$SOURCE_PATH/test"
PROGRAM_FILE="$BUILD_PATH/Program.exe"

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
    bison -do "$BUILD_PATH/Parser.cpp" "$BUILD_PATH/Parser.hpp"

    echo "Compiling C++ file..."
    g++ -std=gnu++11 -o "$PROGRAM_FILE" "$BUILD_PATH/Lexer.cpp" "$BUILD_PATH/Parser.cpp" 

    echo "---------------- DONE ------------------"
}

function run
{   
    compile

    echo "Starting program..."
    echo "----------------------------------------"
    if [ -f "./$PROGRAM_FILE" ]; then
        "./$PROGRAM_FILE"
    else 
        echo "No program file."
        exit 1
    fi  
}

function test 
{
    compile

    echo "Compiling tests..."
    g++ -rdynamic -std=gnu++11 -o "$BUILD_PATH/Test.exe" "$TEST_PATH/Test.cpp"

    echo "Running tests..."
    echo "----------------------------------------"
    if [ -f "$BUILD_PATH/Test.exe" ]; then
        "./$BUILD_PATH/Test.exe"
    else 
        echo "No program file."
        exit 1
    fi 
}

function help
{
    echo "Tupin builder options:"
    echo "  -c | compile  Just compile."
    echo "  -h | help     Shows this message."
    echo "  -r | run      Opens the program after compiling."
    echo "  -t | test     Runs tests after compiling."
}

#################################################
    
if [ "$1" == "" ]; then
    compile
    exit
fi

while [ "$1" != "" ]; do
    case $1 in         
        -h | --help | help )    help
                                exit
                                ;;
        -c | compile )          compile
                                exit
                                ;;
        -t | test )             test
                                exit
                                ;;                                
        -r | run )              run
                                exit
                                ;;
        * )                     help
                                exit 1
    esac
    shift
done
