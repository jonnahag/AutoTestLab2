*** Settings ***
Documentation               Lab 2 - Testar
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime
Suite Setup                  Begin Web Test
Suite Teardown               End Web Test
Test Setup                  Get todays date

*** Variables ***
${BROWSER}                  headlesschrome
${URL}                      http://rental12.infotiv.net/
${TODAYS_DATE}

*** Test Cases ***
User can choose rental dates
    [Documentation]                     Användaren kan välja datum för att hyra bil
    [Tags]                              Välja datum
    Go To Web Page
    Verify startdate is today's date
    Verify enddate is today's date
    Choose startdate
    Choose enddate
    Click Continue

*** IGNORE ***

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
