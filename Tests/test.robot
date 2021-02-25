*** Settings ***
Documentation               Lab 2 - Testar
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime
Test Setup                  Begin Web Test
Test Teardown               End Web Test

*** Variables ***
${BROWSER}                  headlesschrome
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
    Verify chosen enddate               2021-03-05
    Click Continue
    Verify Right Page                   2021-03-03  2021-03-05

Earliest selectable date is today
    [Documentation]                     Användaren kan inte mata in startdatum som är tidigare än dagens datum
    [Tags]                              Startdatum
    Go To Web Page
    Verify startdate is today's date
    Verify enddate is today's date
    Choose startdate                    0222
    Verify chosen startdate             2021-02-22
    Click Continue
    Verify not able to continue

Earliest selectable date is the date selected as start date
    [Documentation]                     Användaren kan inte mata in slutdatum som är tidigare än startdatum
    [Tags]                              Slutdatum
    Go To Web Page
    Verify startdate is today's date
    Verify enddate is today's date
    Choose startdate                    0303
    Verify chosen startdate             2021-03-03
    Choose enddate                      0301
    Verify chosen enddate               2021-03-01
    Click Continue
    Verify not able to continue

Latest selectable date is one month ahead from today
    [Documentation]                     Användaren kan inte mata in slutdatum som är tidigare än startdatum
    [Tags]                              Slutdatum
    Go To Web Page
    Verify startdate is today's date
    Choose startdate                    0326
    Verify chosen startdate             2021-03-26
    Verify startdate max 1 month ahead
