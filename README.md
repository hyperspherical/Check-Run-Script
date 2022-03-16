# Check-Run-Script


Write-Host "================ Eric's Handy 'Check-Run' POWERSHELL Script v1.0 ================"
    Write-Host	"This powershell script records the services/drivers/tasks that are running."
	Write-Host	" "
	Write-Host	"After the inital snapshot, the script can compare and see what has changed."
	Write-Host	" "
	Write-Host	"NOTE: Six files are used by this script, located in C:\ for convenience. "
	Write-Host  "1. services.txt,  2. drivers.txt,  3.tasks.txt"
	Write-Host	"4. services2.txt, 5. drivers2.txt, 6. tasks2.txt"
	Write-Host	" "
	Write-Host	"The best way to use this script is to take a snapshot on a freshly installed"
	Write-Host  "Windows OS with all of the basic software/drivers pre-installed."
	Write-Host	" "
	Write-Host	"This script is very good in helping detect junkware and viruses "
	Write-Host  "that install themselves without permission or notification."
	Write-Host	" "
	Write-Host	"         PLEASE CHOOSE ONE OF THE FOLLOWING OPTIONS:"
	Write-Host	"              ------------------------------"
	Write-Host "1: Press '1' to take a SNAPSHOT of all running software  (This option will overwrite the previous snapshot)"
        Write-Host "2: Press '2' to check the new changes to the SERVICES ***DO NOT CHOOSE BEFORE FIRST USING OPTION 1"
        Write-Host "3: Press '3' to check the new changes to the DRIVERS  ***DO NOT CHOOSE BEFORE FIRST USING OPTION 1"
	Write-Host "4: Press '4' to check the new changes to the TASKS    ***DO NOT CHOOSE BEFORE FIRST USING OPTION 1"
	Write-Host "5: Press 'q' to quit."
