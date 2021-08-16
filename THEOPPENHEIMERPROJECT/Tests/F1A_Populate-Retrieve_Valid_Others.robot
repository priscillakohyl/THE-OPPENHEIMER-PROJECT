*** Settings ***
Library    SeleniumLibrary
Resource    ../Pages/homepage.resource
Resource    ../Pages/common.resource

Test Teardown    Run Keywords    Close Browser

*** Test Cases ***
F1F2A-TC001
    # Test data
    ${data_api} =    Set Variable    ${api_singleInsert}
    ${data_query} =    Set Variable    { "birthday": "01012002", "gender": "m", "name": "John Smith", "natid": "100000001", "salary": "4000", "tax": "100" }
    ${data_natid} =    Set Variable   100000001

    # Expected Results
    ${exp_response} =    Set Variable   202
    ${exp_natid} =     Get Masked ID    ${data_natid}
    ${exp_addition} =    Set Variable    1

    # Pre-requisite: Buffer No Of Records
    POST    ${api_clear}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 1. Post query with the test data provided
    # Query should return Response 200 OK/202 Alright.
    Query Should Return    ${data_api}    ${data_query}    ${exp_response}

    # 2. Go to home page
    # New record should be added to homepage Tax Relief table.
    Close Browser and Reopen URL    ${url}    Chrome

    Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}    ${exp_addition}
    # Accurate information should show up in the relevant columns in Tax Relief Table
    # - natId to display at natId
    Cell Value Should Be    ${tbl_taxRelief}    -1    ${col_natid}    ${exp_natid}

    # - tax relief column to not be empty
    ${taxRelief} =    Get Table Cell    ${tbl_taxRelief}    -1    ${col_relief}
    Should Not Be Empty    ${taxRelief}

F1F2A-TC009
    # Test data
    ${data_api} =    Set Variable    ${api_multipleInsert}
    ${data_query} =    Set Variable    [{ "birthday": "01012002", "gender": "m", "name": "John Smith", "natid": "100000001", "salary": "4000", "tax": "100" },{ "birthday": "01011985", "gender": "f", "name": "Jane Joe", "natid": "200000002", "salary": "4500", "tax": "200" },{ "birthday": "01011970", "gender": "m", "name": "Mary Meh", "natid": "300000003", "salary": "2000", "tax": "50" }]
    ${data_natid1} =    Set Variable   100000001
    ${data_natid2} =    Set Variable   200000002
    ${data_natid3} =    Set Variable   300000003

    # Expected Results
    ${exp_response} =    Set Variable   202
    ${exp_natid1} =     Get Masked ID    ${data_natid1}
    ${exp_natid2} =     Get Masked ID    ${data_natid2}
    ${exp_natid3} =     Get Masked ID    ${data_natid3}
    ${exp_addition} =    Set Variable    3

    # Pre-requisite: Buffer No Of Records
    POST    ${api_clear}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 1. Post query with the test data provided
    # Query should return Response 200 OK/202 Alright.
    Query Should Return    ${data_api}    ${data_query}    ${exp_response}

    # 2. Go to home page
    # 3 New record should be added to homepage Tax Relief table.
    Close Browser and Reopen URL    ${url}    Chrome

    Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}    ${exp_addition}
    # Accurate information should show up in the relevant columns in Tax Relief Table
    # - natId to display at natId
    Cell Value Should Be    ${tbl_taxRelief}    -3    ${col_natid}    ${exp_natid1}
    Cell Value Should Be    ${tbl_taxRelief}    -2    ${col_natid}    ${exp_natid2}
    Cell Value Should Be    ${tbl_taxRelief}    -1    ${col_natid}    ${exp_natid3}

    # - tax relief column to not be empty
    ${taxRelief1} =    Get Table Cell    ${tbl_taxRelief}    -3    ${col_relief}
    Should Not Be Empty    ${taxRelief1}
    ${taxRelief2} =    Get Table Cell    ${tbl_taxRelief}    -2    ${col_relief}
    Should Not Be Empty    ${taxRelief2}
    ${taxRelief3} =    Get Table Cell    ${tbl_taxRelief}    -1    ${col_relief}
    Should Not Be Empty    ${taxRelief3}

F1F2A-TC017
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    Element Should Be Enabled    ${btn_uploadfile}

F1F2A-TC018
    # Test data
    ${data_csvpath} =    Set Variable    ${CURDIR}\\upload\\CSV_pop.csv
    ${data_natid1} =    Set Variable   110000001
    ${data_natid2} =    Set Variable   120000002
    ${data_natid3} =    Set Variable   130000003
    ${data_natid4} =    Set Variable   140000004
    ${data_natid5} =    Set Variable   150000005

    # Expected Results
    ${exp_natid1} =     Get Masked ID    ${data_natid1}
    ${exp_natid2} =     Get Masked ID    ${data_natid2}
    ${exp_natid3} =     Get Masked ID    ${data_natid3}
    ${exp_natid4} =     Get Masked ID    ${data_natid4}
    ${exp_natid5} =     Get Masked ID    ${data_natid5}
    ${exp_addition} =    Set Variable    5

    # Pre-requisite: Buffer No Of Records
    # 1. Go to home page
    POST    ${api_clear}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 2. Click on 'Browse' and upload .csv file
    Choose File    ${btn_uploadfile}    ${data_csvpath}

    # 5 new records should be added to homepage Tax Relief table.
    Close Browser and Reopen URL    ${url}    Chrome
    Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}    ${exp_addition}

    # The 5 new records of natId should correspond with test data.
    Cell Value Should Be    ${tbl_taxRelief}    -5    ${col_natid}    ${exp_natid1}
    Cell Value Should Be    ${tbl_taxRelief}    -4    ${col_natid}    ${exp_natid2}
    Cell Value Should Be    ${tbl_taxRelief}    -3    ${col_natid}    ${exp_natid3}
    Cell Value Should Be    ${tbl_taxRelief}    -2    ${col_natid}    ${exp_natid4}
    Cell Value Should Be    ${tbl_taxRelief}    -1    ${col_natid}    ${exp_natid5}

F1F2A-TC019
    # Test data
    ${data_csvpath} =    Set Variable    ${CURDIR}\\upload\\TXT_pop.txt

    # Pre-requisite: Buffer No Of Records
    # 1. Go to home page
    POST    ${api_clear}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 2. Click on 'Browse' and upload .csv file
    Choose File    ${btn_uploadfile}    ${data_csvpath}
    # List Directory    ${CURDIR}

    # No changes should be made.
    Close Browser and Reopen URL    ${url}    Chrome
    No Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}

F1F2A-TC020
    # Test data
    ${data_csvpath} =    Set Variable    ${CURDIR}\\upload\\CSV_pop_invaliddate.csv

    # Pre-requisite: Buffer No Of Records
    # 1. Go to home page
    POST    ${api_clear}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    ${noOfRecords} =    Get Total Table Rows    ${tbl_taxRelief}

    # 2. Click on 'Browse' and upload .csv file
    Choose File    ${btn_uploadfile}    ${data_csvpath}

    # No changes should be made.
    Close Browser and Reopen URL    ${url}    Chrome
    No Records Should Be Added    ${tbl_taxRelief}    ${noOfRecords}

F1F2A-TC021
    # Test data
    ${data_csvpath} =    Set Variable    ${CURDIR}\\upload\\CSV_pop_get.csv
    ${data_api} =    Set Variable    ${api_get}
    ${data_natid1} =    Set Variable   210000001
    ${data_natid2} =    Set Variable   220000002
    ${data_natid3} =    Set Variable   230000003
    ${data_natid4} =    Set Variable   240000004
    ${data_natid5} =    Set Variable   250000005
    ${data_name1} =    Set Variable   Mark Spencer
    ${data_name2} =    Set Variable   Bryan Lim
    ${data_name3} =    Set Variable   Destiny Child
    ${data_name4} =    Set Variable   Tiffany Turquoise
    ${data_name5} =    Set Variable   Tan Lee Ming

    # Expected Results
    ${exp_natid1} =     Get Masked ID    ${data_natid1}
    ${exp_natid2} =     Get Masked ID    ${data_natid2}
    ${exp_natid3} =     Get Masked ID    ${data_natid3}
    ${exp_natid4} =     Get Masked ID    ${data_natid4}
    ${exp_natid5} =     Get Masked ID    ${data_natid5}

    # Pre-requisite: Clean records
    POST    ${api_clear}

    # 1. Go to home page
    Open Browser    ${url}    Chrome
    Maximize Browser Window

    # 2. Click on 'Browse' and upload .csv file
    Choose File    ${btn_uploadfile}    ${data_csvpath}

    # 3. Post GET request
    GET    ${data_api}
    ${response} =  Output    response body
    # natId field values should be masked from 5th character onwards.
    # natId and name values return should correspond with test data provided
    ${count} =    Set Variable    1
    FOR    ${record}    IN    @{response}
        ${natid} =    Get From Dictionary   ${record}    natid
        NatId Should Be Masked    ${natid}
        Should Be Equal    ${natid}    ${exp_natid${count}}

        ${name} =    Get From Dictionary   ${record}    name
        Should Be Equal    ${name}    ${data_name${count}}

        ${count} =    Evaluate    ${count} + 1
    END
