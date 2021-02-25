*** Settings ***
Documentation               Lab 2 - Testar
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime
Test Setup                  Begin Web Test
Test Teardown               End Web Test

*** Variables ***
${BROWSER}                  chrome
${URL}                      http://rental12.infotiv.net/

*** Test Cases ***
User can access website
    [Documentation]                     Användaren kommer åt hemsidan
    [Tags]                              Testar åtkomst
    Go To Web Page
    Verify startdate is today's date
    Verify enddate is today's date
    Choose startdate                    0303
    Verify chosen startdate             2021-03-03
    Choose enddate                      0305
    #Verify chosen enddate               2021-03-05
    Click Continue
    Verify Right Page
