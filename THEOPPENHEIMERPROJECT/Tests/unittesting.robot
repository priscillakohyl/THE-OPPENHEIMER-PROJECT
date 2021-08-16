*** Settings ***
Library    SeleniumLibrary
Library    REST
Library    DataDriver
Resource    ../Pages/common.resource
Resource    ../Pages/homepage.resource

*** Variables ***
${date} =    01011994
${date_1} =    01012004
${date_0-8} =    01011987
${date_0-5} =    01011972
${date_0-367} =    01011947
${date_0-05} =    01011944

${value} =    398410.324325235

${url}    http://localhost:8080/
${tbl_taxRelief}    xpath://table[@class="table table-hover table-dark"]

*** Test Cases ***
Verify Get Age
    ${age} =    Get Age From Date    ${date}
    
Verify Get Current Year
    ${currentYear} =    Get Current Year
    
Verify Get Variable From Age
    ${variable} =    Get Variable From Birthday    ${date_0-8}
    ${variable} =    Get Variable From Birthday    ${date_0-5}
    # ${variable} =    Get Variable From Birthday    ${date_0-367}
    # ${variable} =    Get Variable From Birthday    ${date_0-05}  

Verify Get Tax Relief
    ${taxRelief} =    Get Tax Relief    1010    10    12122004    m
    # ${taxRelief} =    Get Tax Relief    1010    10    12121987    m
    # ${taxRelief} =    Get Tax Relief    1010    10    12121972    m
    # ${taxRelief} =    Get Tax Relief    1010    10    12121947    m
    # ${taxRelief} =    Get Tax Relief    1010    10    12121944    m
    
Verify Get Rounded Value
    ${roundedvalue} =    Evaluate    '%.2f'%(${value})
    ${roundedvalue} =    Evaluate    '%.2f'%(round(${roundedvalue}))
    
    ${roundedvalue} =    Set Variable If
    ...    ${roundedvalue} > 0 and ${roundedvalue} < 50    50.00
    ...    ${roundedvalue} > 50    ${roundedvalue}
    
Verify API GET
    GET    http://localhost:8080/calculator/taxRelief    
    [Teardown]  Output    response body
    
Verify API POST Single
    POST    http://localhost:8080/calculator/insert    { "birthday": "01012002", "gender": "f", "name": "Priscilla", "natid": "1010101010", "salary": "1010", "tax": "10" }
    Output  response
    
Verify Get Table Rows
    Open Browser    ${url}    Chrome
    ${noOfRows} =    Get Total Table Rows    ${tbl_taxRelief}
    
Verify Get Masked ID
    ${masked} =    Get Masked ID    100000001
    
Verify API POST Single Fail
    POST    http://localhost:8080/calculator/insert    { "gender": "f", "name": "Priscilla", "natid": "1010101010", "salary": "1010", "tax": "10" }
    ${response} =  Output  response 
    # Should Contain    ${response}    Error
Get Directory
    List Directory    ${CURDIR}
    
Verify Clear
    POST    ${api_clear}
    
Verify GET
    GET    http://localhost:8080/calculator/taxRelief
    ${response} =  Output    response body
    
    FOR    ${record}    IN    @{response}
        ${natid} =    Get From Dictionary   ${record}    natid
        NatId Should Be Masked    ${natid}
        ${name} =    Get From Dictionary   ${record}    name 
    END
    
Verify Rounded
    Get Rounded Value    49.10
    Get Rounded Value    49.50
    Get Rounded Value    49.90