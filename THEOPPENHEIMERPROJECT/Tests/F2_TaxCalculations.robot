*** Settings ***
Library     SeleniumLibrary
Resource    ../Pages/homepage.resource
Resource    ../Pages/common.resource

Library    DataDriver    ../data/TestData_CalcTax.csv

Test Teardown    Run Keywords    Close Browser
Test Template    Calculate Tax

*** Test Cases ***
F2 - ${tcid} : ${desc}

*** Keywords ***
Calculate Tax
    [Arguments]     ${data_csvpath}  ${data_salary}  ${data_taxpaid}  ${data_birthday1}  ${data_birthday2}
    ...             ${data_birthday3}  ${data_birthday4}  ${data_birthday5}  ${data_birthday6}  ${data_gender1}
    ...             ${data_gender2}  ${data_gender3}  ${data_gender4}  ${data_gender5}  ${data_gender6}

    # Expected Results
    ${exp_relief1} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday1}    ${data_gender1}
    ${exp_relief2} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday2}    ${data_gender2}
    ${exp_relief3} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday3}    ${data_gender3}
    ${exp_relief4} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday4}    ${data_gender4}
    ${exp_relief5} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday5}    ${data_gender5}
    ${exp_relief6} =    Get Tax Relief    ${data_salary}    ${data_taxpaid}    ${data_birthday6}    ${data_gender6}

    # Pre-requisite: Clean records
    POST    ${api_clear}

    # 1. Go to home page
    Open Browser    ${url}    Chrome
    Maximize Browser Window

    # 2. Click on 'Browse' and upload .csv file
    Choose File    ${btn_uploadfile}    ${data_csvpath}

    #3. Post GET request
    GET    ${api_get}
    ${response} =  Output    response body
    # Tax Relief Amount should be calculated based on the formula below:
    # tax relief = ((salary - tax paid) * variable) + gender bonus
    ${count} =    Set Variable    1
    FOR    ${record}    IN    @{response}
        ${relief} =    Get From Dictionary   ${record}    relief
        Should Be Equal    ${relief}    ${exp_relief${count}}

        ${count} =    Evaluate    ${count} + 1
    END