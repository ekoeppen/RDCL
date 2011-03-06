@echo off
echo Compiling necessary modules... 
call rake compile

echo Installing...
call rake install

echo Done.

