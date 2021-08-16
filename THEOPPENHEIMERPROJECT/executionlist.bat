@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date/t') do (set mydate=%%c%%a%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)

set prefix=%mydate%%mytime%_"F1A"
robot Tests\F1A_Populate-Retrieve_Valid_Others.robot
move "report.html" "reports/%prefix%_report.html"
move "log.html" "reports/%prefix%_log.html"
move "output.xml" "reports/%prefix%_output.xml"

set prefix=%mydate%%mytime%_"F1B"
robot Tests\F1B_Populate-Retrieve_Invalid.robot
move "report.html" "reports/%prefix%_report.html"
move "log.html" "reports/%prefix%_log.html"
move "output.xml" "reports/%prefix%_output.xml"

set prefix=%mydate%%mytime%_"F2"
robot Tests\F2_TaxCalculations.robot
move "report.html" "reports/%prefix%_report.html"
move "log.html" "reports/%prefix%_log.html"
move "output.xml" "reports/%prefix%_output.xml"

set prefix=%mydate%%mytime%_"F3"
robot Tests\F3_Dispense.robot
move "report.html" "reports/%prefix%_report.html"
move "log.html" "reports/%prefix%_log.html"
move "output.xml" "reports/%prefix%_output.xml"

set prefix=%mydate%%mytime%_"F4"
robot Tests\F4_Miscellaenous.robot
move "report.html" "reports/%prefix%_report.html"
move "log.html" "reports/%prefix%_log.html"
move "output.xml" "reports/%prefix%_output.xml"

echo Execution is done. Please view reports here:
echo %cd%\Reports
echo Press any key to close executionlist.bat_
pause > nul