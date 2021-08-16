*** Settings ***
Library    SeleniumLibrary
Resource    ../Pages/homepage.resource
Resource    ../Pages/common.resource

Test Teardown    Run Keywords    Close Browser

*** Test Cases ***
F4-TC001
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}
    ${noOfRows} =    Evaluate    ${noOfRecords} + 1
    #Calculate Total Relief
    ${totalRelief} =    Set Variable    0
    FOR    ${i}    IN RANGE    1   ${noOfRows}
        ${index} =    Evaluate    ${i} + 1
        ${relief} =    Get Table Cell    ${tbl_taxRelief}    ${index}    ${col_relief}
        ${totalRelief} =    Evaluate    '%.2f'%(${totalRelief} + ${relief})
    END
    
    ${totalReliefAmount} =    Convert To String    ${totalRelief}
    ${totalReliefMsg} =    Catenate    ${totalReliefAmount}    will be dispensed to    ${noOfRecords}    Working Class Hero
    Element Should Contain    ${lbl_totalTaxRelief}    ${totalReliefMsg}