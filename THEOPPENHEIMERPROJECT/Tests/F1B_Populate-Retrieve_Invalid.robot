*** Settings ***
Library    SeleniumLibrary
Library    REST
Resource    ../Pages/homepage.resource
Resource    ../Pages/common.resource

Library    DataDriver    ../data/TestData_Invalid.csv

Test Teardown    Run Keywords    Close Browser
Test Template    Invalid insertion

*** Test Cases ***
F1F2A- ${tcid} : ${desc}

*** Keywords ***
Invalid insertion
    [Arguments]     ${data_api}    ${data_query}

    # Pre-requisite: Buffer No Of Records
    Clear Existing Records
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 1. Post query with the test data provided
    # Query should return Response 500.
    Query Should Return    ${data_api}    ${data_query}    500

    # 2. Go to home page
    # There should be no changes to homepage Tax Relief table.
    Close Browser and Reopen URL    ${url}    Chrome
    No Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}
