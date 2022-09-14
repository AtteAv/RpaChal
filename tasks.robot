*** Settings ***
Documentation       RPA Challenge Input forms implementation in robotframework

Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Tables
Library             RPA.Excel.Files
Library             Collections


*** Tasks ***
Complete RPA challenge
    #Get spreadsheet
    ${infotable}=    Handle spreadsheet
    Go to website
    Press start

    FOR    ${personInfo}    IN    @{infotable}
        Fill online form with person data    ${personinfo}
        Submit info
    END

    Sleep    5s
    [Teardown]    Close Browser


*** Keywords ***
Get spreadsheet
    Download    https://rpachallenge.com/assets/downloadFiles/challenge.xlsx

Handle spreadsheet
    Open Workbook    challenge.xlsx
    ${challengeData}=    Read Worksheet As Table    header=True
    Close Workbook
    RETURN    ${challengeData}

Go to website
    Open Available Browser    https://rpachallenge.com/

Press start
    Wait Until Element Is Visible    xpath=//button[contains (text(), "Start")]
    Click Button    xpath=//button[contains (text(), "Start")]

Fill online form with person data
    [Arguments]    ${personinfo}
    Wait and fill    xpath=//input[@ng-reflect-name="labelFirstName"]    ${personInfo}[First Name]
    Wait and fill    xpath=//input[@ng-reflect-name="labelLastName"]    ${personInfo}[Last Name]
    Wait and fill    xpath=//input[@ng-reflect-name="labelCompanyName"]    ${personInfo}[Company Name]
    Wait and fill    xpath=//input[@ng-reflect-name="labelRole"]    ${personInfo}[Role in Company]
    Wait and fill    xpath=//input[@ng-reflect-name="labelAddress"]    ${personInfo}[Address]
    Wait and fill    xpath=//input[@ng-reflect-name="labelEmail"]    ${personInfo}[Email]
    Wait and fill    xpath=//input[@ng-reflect-name="labelPhone"]    ${personInfo}[Phone Number]

Wait and fill
    [Arguments]    ${target}    ${text}
    Wait Until Element Is Visible    ${target}
    Input Text    ${target}    ${text}

Submit info
    ${sub_button}=    Set Variable    xpath=//input[@type="submit"]
    Wait Until Element Is Visible    ${sub_button}

    Click Button    ${sub_button}
