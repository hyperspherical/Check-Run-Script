#Version 1.0 Released on 3/16/2022
#The author Eric is not liable for any damage this script may cause or be involved with. 
#Use at your own descrection, and only after proof-reading the code below to see how it works.
#All permissions are granted to use any part of this script as long as any modifications are 
#also kept free of charge for the support of the software community.

function Show-Menu {	
	Clear-Host
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
}

$counter=0

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
		'1' {
			Get-Service | Where Status -eq "Running" | Format-Table -Property name -HideTableHeaders > c:\services.txt
			Get-Process | Format-Table  -Property name -HideTableHeaders > c:\tasks.txt
			driverquery /FO CSV | ConvertFrom-CSV | Select-Object 'Module Name' > c:\drivers.txt
			Write-Host "Snapshot Aquired and recorded..."
			#return
		} '2' {
		
			Write-Host "Capturing Currently Running Services..."
			Get-Service | Where Status -eq "Running" | Format-Table -Property name -HideTableHeaders > c:\services2.txt
			
			Write-Host "Comparing to the services snapshot..."

				$stream_reader1 = New-Object System.IO.StreamReader{C:\services.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\services2.txt}
				$counter = 0
				
				#-------------------Find matching services, and count duplicates
				
				
				#First read and skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
					
				while ($current_line1 -ne $null)
				{
					while ($current_line2 -ne $null)	{
						if ($current_line1.Trim() -eq $current_line2.Trim() ) {$counter++}
						$current_line2 = $stream_reader2.ReadLine()
					}
					
					if ($counter -eq 0) {
						Write-Host "Service named $current_line1 is no longer running"	
					} 
					
					#open up file to start at the  begining again
					$stream_reader2.Close()
					$stream_reader2 = New-Object System.IO.StreamReader{C:\services2.txt}
					
					#skip over the new lines 
					$current_line2 = $stream_reader2.ReadLine()
					$current_line2 = $stream_reader2.ReadLine()
					
					$current_line1 = $stream_reader1.ReadLine()
					
					$counter = 0
				}

				$stream_reader1.Close()
				$stream_reader2.Close()
				
				#----------
				Write-Host "Finding New Services..."
				$stream_reader1 = New-Object System.IO.StreamReader{C:\services.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\services2.txt}
				$counter = 0
				
				#skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				
				#-------------------Find new services, and count new duplicates
				while ($current_line2 -ne $null)
				{
					while ($current_line1 -ne $null) {
						if ($current_line1.Trim() -eq $current_line2.Trim()) {$counter++}
						$current_line1 = $stream_reader1.ReadLine()
					}
					
					if ($counter -eq 0) {
						Write-Host "Service named $current_line2 is NEW."	
					} 
					
					#open up file from begining again
					$stream_reader1.Close()
					$stream_reader1 = New-Object System.IO.StreamReader{C:\services.txt}
					$current_line1 = $stream_reader1.ReadLine()
					$current_line1 = $stream_reader1.ReadLine()	
				
					$current_line2 = $stream_reader2.ReadLine()
				
					$counter = 0
				}
				
				$stream_reader1.Close()
				$stream_reader2.Close()
				#return
			
			#---------------------------
			} '3' {
			
				Write-Host "Capturing Currently Running Drivers..."
				driverquery /FO CSV | ConvertFrom-CSV | Select-Object 'Module Name' > c:\drivers2.txt

				Write-Host "Comparing to the drivers snapshot..."

				$stream_reader1 = New-Object System.IO.StreamReader{C:\drivers.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\drivers2.txt}
				$counter = 0
			
				#-------------------Find matching drivers, and count duplicates
				
				#First read and skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				
				while ($current_line1 -ne $null)
				{
					while ($current_line2 -ne $null){
						
						if ($current_line1.Trim() -eq $current_line2.Trim()) {$counter++}
						
						$current_line2 = $stream_reader2.ReadLine()
					}
					if ($counter -eq 0) {Write-Host "Driver named $current_line1 is no longer running"} 
					
					#open up file to start at the  begining again
					$stream_reader2.Close()
					$stream_reader2 = New-Object System.IO.StreamReader{C:\drivers2.txt}
					
					#skip over the first few lines
					$current_line2 = $stream_reader2.ReadLine()
					$current_line2 = $stream_reader2.ReadLine()
					$current_line2 = $stream_reader2.ReadLine()
					$current_line2 = $stream_reader2.ReadLine()
				
					$current_line1 = $stream_reader1.ReadLine()
					
					$counter = 0
				}

				$stream_reader1.Close()
				$stream_reader2.Close()
				
				#----------
				Write-Host "Finding New Drivers..."
				$stream_reader1 = New-Object System.IO.StreamReader{C:\drivers.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\drivers2.txt}
				$counter = 0
				
				#skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				$current_line1 = $stream_reader1.ReadLine()
				
				
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
								
				#-------------------Find new and count new duplicates
				while ($current_line2 -ne $null)
				{
					while ($current_line1 -ne $null) {
						if ($current_line1.Trim() -eq $current_line2.Trim()) {$counter++}
						
						$current_line1 = $stream_reader1.ReadLine()
					}
					
					if ($counter -eq 0) {Write-Host "$counter Driver named $current_line2 is NEW."}
					
					#open up file from begining again
					$stream_reader1.Close()
					$stream_reader1 = New-Object System.IO.StreamReader{C:\drivers.txt}
					
					$current_line1 = $stream_reader1.ReadLine()
					$current_line1 = $stream_reader1.ReadLine()	
					$current_line1 = $stream_reader1.ReadLine()	
					$current_line1 = $stream_reader1.ReadLine()	
				
					$current_line2 = $stream_reader2.ReadLine()
				
					$counter = 0
				}
				
				$stream_reader1.Close()
				$stream_reader2.Close()
				
				#return
		
			#---------------------------
			} '4' {
				Write-Host "Capturing Currently Running Tasks..."
				Get-Process | Format-Table  -Property name -HideTableHeaders > c:\tasks2.txt
				
				Write-Host "Comparing to the tasks snapshot..."
				
				$stream_reader1 = New-Object System.IO.StreamReader{C:\tasks.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\tasks2.txt}
				$counter = 0
				
				#-------------------Find matching drivers, and count duplicates
				
				#First read and skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
					
				while ($current_line1 -ne $null)
				{
					while ($current_line2 -ne $null)	{
						
						if ($current_line1.Trim() -eq $current_line2.Trim() ) {$counter++}
						
						$current_line2 = $stream_reader2.ReadLine()
					}
					
					if ($counter -eq 0) {Write-Host "Task named $current_line1 is no longer running"} 
					
					#open up file to start at the  begining again
					$stream_reader2.Close()
					$stream_reader2 = New-Object System.IO.StreamReader{C:\tasks2.txt}
					
					$current_line2 = $stream_reader2.ReadLine()
					$current_line1 = $stream_reader1.ReadLine()
					
					$counter = 0
				}

				$stream_reader1.Close()
				$stream_reader2.Close()
				
				#----------
				Write-Host "Finding New Tasks..."
				$stream_reader1 = New-Object System.IO.StreamReader{C:\tasks.txt}
				$stream_reader2 = New-Object System.IO.StreamReader{C:\tasks2.txt}
				$counter = 0
				
				#skip over the new lines left over from capture commands
				$current_line1 = $stream_reader1.ReadLine()
				$current_line2 = $stream_reader2.ReadLine()
				
				#-------------------Find new services, and count new duplicates
				while ($current_line2 -ne $null)
				{
					while ($current_line1 -ne $null) {
						if ($current_line1.Trim() -eq $current_line2.Trim()) {$counter++}
						$current_line1 = $stream_reader1.ReadLine()
					}
					
					if ($counter -eq 0) {
						Write-Host "Task named $current_line2 is NEW."	
					} 
					
					#open up file from begining again
					$stream_reader1.Close()
					$stream_reader1 = New-Object System.IO.StreamReader{C:\tasks.txt}
					$current_line1 = $stream_reader1.ReadLine()
					
					$current_line2 = $stream_reader2.ReadLine()
				
					$counter = 0
				}
				
				$stream_reader1.Close()
				$stream_reader2.Close()
				
				#return
			
			}
		}
	
	pause
 } while ($selection -ne 'q')
 
