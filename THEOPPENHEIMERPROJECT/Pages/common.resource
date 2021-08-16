***Settings***
Library    String
Library    DateTime
Library    OperatingSystem
Library    SeleniumLibrary
Library    Process
Library    Collections

*** Keywords ***
Get Age From Date
    [Arguments]    ${birthday}
    ${year} =    Get Substring    ${birthday}    4    end=None
    ${currentYear} =    Get Current Year
    ${age} =    Evaluate    ${currentYear} - ${year}    
    [Return]    ${age}

Get Current Year
    ${currentdate} =    Get Current Date    result_format=datetime
    #Convert currentdate to String
    ${date} =    Convert Date    ${currentdate}    result_format=timestamp 
    ${year} =    Get Substring    ${date}    0    4
    [Return]    ${year}
    
Element Class Should Contain
    [Arguments]    ${webelement}    ${text}
    ${class} =    Get Element Attribute    ${webelement}    class
    Should Contain    ${class}    ${text}
    
Get Total Table Rows    
    [Arguments]    ${table}
    ${numberOfRows} =    Get Element Count    ${table}/tbody/tr
    [Return]    ${numberOfRows}
    
Get Table Last Row Index
    [Arguments]    ${table}
    ${numberOfRows} =    Get Total Table Rows    ${table}
    [Return]    ${numberOfRows}
    
Close Browser and Reopen URL
    [Arguments]    ${url}    ${browser}
    Close Browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    