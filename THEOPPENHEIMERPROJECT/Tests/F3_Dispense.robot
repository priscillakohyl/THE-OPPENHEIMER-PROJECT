*** Settings ***
Library    SeleniumLibrary
Resource    ../Pages/homepage.resource

# Suite Setup    Set Screenshot Directory    /Screenshots/
Test Teardown    Run Keywords    Close Browser


*** Test Cases ***
F3-TC001
    Open Browser    ${url}    Chrome
    Element Should Be Enabled    ${btn_dispenseNow}
    Element Class Should Contain    ${btn_dispenseNow}    btn-danger
    Element Text Should Be    ${btn_dispenseNow}   Dispense Now
    
F3-TC002
    Open Browser    ${url}    Chrome
    Click Element    ${btn_dispenseNow}
    Location Should Contain    dispense
    Page Should Contain    Cash dispensed
    
    