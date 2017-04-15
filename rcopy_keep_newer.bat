#This robocopy command will copy files from S:\ to N: but skip the file if it is newer on N.  It will output to screen as well as a log file called 5_22.txt. Change your drive mapping for S and N as well as log file name as needed
#This can be run from a command line or powershel CLI
robocopy "S:"  "N:"  /E /FFT /XO /COPY:DATO /log:5_22.txt /tee /ndl /np /xx