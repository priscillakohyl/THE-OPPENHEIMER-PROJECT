***Settings***
Resource    common.resource
Library    REST

*** Variables ***
${url}    http://localhost:8080/

${api_singleInsert} =    http://localhost:8080/calculator/insert
${api_multipleInsert} =    http://localhost:8080/calculator/insertMultiple
${api_get} =    http://localhost:8080/calculator/taxRelief
${api_clear} =    http://localhost:8080/calculator/rakeDatabase

${btn_uploadfile}    xpath://input[@class="custom-file-input"]
${btn_refreshTable}    xpath://*[@id="contents"]/button[contains(., 'Refresh Tax Relief Table')]
${btn_dispenseNow}   link:Dispense Now

${tbl_taxRelief}    xpath://table[@class="table table-hover table-dark"]
${col_natid} =    1
${col_relief} =    2

${lbl_totalTaxRelief}    xpath://div[@id="contents"]/div[@class="jumbotron jumbotron-fluid"]/div[@class="container"]/p[@class="lead"]

${var_18}    1
${var_35}    0.8
${var_50}    0.5
${var_75}    0.367
${var_76}    0.05

${bonus_m}    0
${bonus_f}    500


*** Keywords ***

Get Tax Relief
    [Arguments]    ${salary}    ${taxPaid}    ${birthday}    ${gender}
    ${variable} =    Get Variable From Birthday    ${birthday}
    ${genderBonus} =    Get Gender Bonus    ${gender}
    ${taxRelief} =    Evaluate    ((${salary} - ${taxPaid}) * ${variable}) + ${genderBonus}

    #F2 - AC6: truncated at the second decimal place
    ${taxRelief} =    Evaluate    '%.2f'%(${taxRelief})

    #F2 - AC4: normal rounding rule
    ${taxRelief} =    Get Rounded Value    ${taxRelief}

    #F2 - AC5: If more than 0.00 but less than 50.00
    ${taxRelief} =    Set Variable If
    ...    ${taxRelief} > 0 and ${taxRelief} < 50    50.00
    ...    ${taxRelief} > 50    ${taxRelief}

    [Return]    ${taxRelief}

Get Rounded Value
    [Arguments]    ${value}
    # 49.5
    ${rounded} =    Evaluate    '%.2f'%(round(${value}))
    ${rounddown} =    Evaluate    '%.2f'%(${rounded} - 1)
    ${remain} =    Evaluate    ${value} % 1

    ${final} =    Set Variable If
    ...    ${remain} == 0.5    ${rounddown}
    ...    ${remain} < 0.5 or ${remain} > 0.5    ${rounded}
    [Return]    ${final}


Get Variable From Birthday
    [Arguments]    ${birthday}
    ${age} =    Get Age From Date    ${birthday}

    ${variable} =    Set Variable If
    ...    ${age} < 19    ${var_18}
    ...    ${age} < 36 and ${age} > 18    ${var_35}
    ...    ${age} < 51 and ${age} > 35    ${var_50}
    ...    ${age} < 76 and ${age} > 50    ${var_75}
    ...    ${age} > 75    ${var_76}

    [Return]    ${variable}

Get Gender Bonus
    [Arguments]    ${gender}
    ${bonus} =    Set Variable If
    ...    """${gender}""" == """m"""    ${bonus_m}
    ...    """${gender}""" == """f"""    ${bonus_f}

    [Return]    ${bonus}

Get Masked ID
    [Arguments]    ${natid}
    ${length} =    Get Length    ${natid}
    ${noOfMask} =    Evaluate    ${length} - 4
    ${unmasked} =    Get Substring    ${natid}    0    4
    # Start generating masked id
    ${maskedid} =    Set Variable    ${unmasked}
    FOR    ${index}    IN RANGE    ${noOfMask}
        ${maskedid} =    Catenate    ${maskedid}    $
    END
    ${maskedid} =    Evaluate    """${maskedid}""".replace(" ","")
    [Return]    ${maskedid}

Records Should Be Added
    [Arguments]    ${table}    ${initialNoOfRecords}    ${expectedNoOfAddition}
    ${currentNoOfRecords} =    Get Total Table Rows    ${table}
    ${noOfAddition} =    Evaluate    ${currentNoOfRecords} - ${initialNoOfRecords}
    ${expectedNoOfAddition} =    Convert To Integer    ${expectedNoOfAddition}
    Should Be Equal    ${noOfAddition}    ${expectedNoOfAddition}

No Records Should Be Added
    [Arguments]    ${table}    ${initialNoOfRecords}
    Records Should Be Added    ${table}    ${initialNoOfRecords}    0


Cell Value Should Be
    [Arguments]    ${table}    ${row}    ${col}    ${value}
    ${cellValue} =    Get Table Cell    ${table}    ${row}    ${col}
    Should Be Equal    ${cellValue}    ${value}

Query Should Return
    [Arguments]    ${api}    ${query}    ${expectedResult}
    POST    ${api}    ${query}
    ${response} =  Output  response status
    ${response} =    Convert To String    ${response}
    Should Be Equal    ${response}    ${expectedResult}

NatId Should Be Masked
    [Arguments]    ${natid}
    ${length} =    Get Length    ${natid}
    ${xtimes} =    Evaluate    ${length} - 4
    ${substring} =    Get Substring    ${natid}    4    end=None
    Should Contain X Times    ${substring}    \$    ${xtimes}

Clear Existing Records
    POST    ${api_clear}