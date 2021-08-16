# Introduction
This is a submission for THE OPPENHEIMER PROJECT by Priscilla Koh.
 
The test suite verifies for the 3 features of the portal:
F1: Enable Clerks to populate a list of working class heroes to the system
F2: Enable Bookkeepers to retrieve the payable taxation relief for each working class
F3: Enable Governor to dispense the money to each working class hero at her discretion

This testsuite is scripted in Python 3.9 using Robot Framework 3.3.2. 
This is a loose interpretation of the Page Object Model. You may find the 'Page' in /THEOPPENHEIMERPROJECT/Tests/, and the 'Object' and custom keywords in /THEOPPENHEIMERPROJECT/Pages/.
You may also find that the scripts are structured in a way where generating many similar testcases is easy - there are 3 visible sections in each testcase - Test data, Expected Results and the Steps (Pre-requisite, Step 1 2 3 etc). As such, the test script will be more readable and user friendly.

# Files:
* PriscillaSubmission
	* (Folder) THEOPPENHEIMERPROJECT
	Contains the test scripts and resource files.
		* data
		Contains test data for templates
		* Pages
		* Reports
		* Tests
			*upload
			Contains csv files to test csv uploads
		* venv
		executionlist.bat
	* OppenheimerProjectDev.jar
	* README.txt
	* Strategy.docx
	* Testcases.xlsx

The Strategy.docx contains the test strategy and assumptions made for the test cases. It can be found in the Submission Folder, together with the Testcases.xlsx which the test scripts are based off.  

Testsuite executable file, executionlist.bat can be found in the /THEOPPENHEIMERPROJECT/ folder. Once the OppenheimerProjectDev.jar is started, you can run the executionlist.bat and the reports of the run will be saved in /reports/.

# How to Start
1. Copy Project Directory and start the OppenheimerProjectDev.jar in cmd
> java -jar (Directory)\OppenheimerProjectDev.jar
eg. java -jar C:\Users\Priscilla\PriscillaSubmission\OppenheimerProjectDev.jar

2. Once done, you may find executionlist.bat in folder THEOPPENHEIMERPROJECT. Double click on executionlist.bat; Test will begin.

3. Once done you may view report in THEOPPENHEIMERPROJECT/Reports/

# Test Summary
## F1A - Valid Population & Retrieval
Total Testcases: 7
1 Expected Failures
6 Expected Passes

## F1B - Invalid Population & Retrieval
Total Testcases: 14
2 Expected Failures
12 Expected Passes

## F2_TaxCalculations
Total Testcases: 4
0 Expected Failures
4 Expected Passes

## F3 - Dispense
Total Testcases: 2
0 Expected Failures
2 Expected Passes

## F4 - Miscellaenous
Total Testcases: 1
0 Expected Failures
1 Expected Passes
