*** Settings ***
Documentation               Lab 2 - Testar
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime
Suite Setup                  Begin Web Test
Suite Teardown               End Web Test
#Test Setup                  Get todays date

*** Variables ***
${BROWSER}                  chrome
${URL}                      http://rental12.infotiv.net/
#${TODAYS_DATE}

*** Test Cases ***
User can access website with correct current dates
    [Documentation]                     Kollar att sidan har rätt startdatum (dagens datum)
    [Tags]                              Startvärden
    Go To Web Page
    Verify startdate is today's date
    Verify enddate is today's date

User can choose rental dates
    [Documentation]                     Användaren kan välja datum för att hyra bil
    [Tags]                              Välja datum     Startdatum      Slutdatum
    Go To Web Page
    Choose startdate
    Choose enddate
    Click Continue
    Verify Right Page

Earliest selectable startdate is today
    [Documentation]                     Användaren kan inte mata in startdatum som är tidigare än dagens datum
    [Tags]                              Startdatum      Ogiltig
    Go To Web Page
    Choose too early startdate
    Click Continue

Earliest selectable enddate is the date selected as startdate
    [Documentation]                     Användaren kan inte mata in slutdatum som är tidigare än startdatum
    [Tags]                              Slutdatum       Ogiltig
    Go To Web Page
    Choose startdate
    Choose too early enddate
    Click Continue

Latest selectable startdate is one month ahead from today
    [Documentation]                     Användaren kan inte mata in slutdatum som är tidigare än startdatum
    [Tags]                              Startdatum      Ogiltig
    Go To Web Page
    Choose too late startdate
    Click Continue

Latest selectable enddate is one month ahead from startdate
    [Documentation]                     Användaren kan inte mata in slutdatum som är tidigare än startdatum
    [Tags]                              Slutdatum       Ogiltig
    Go To Web Page
    Choose too late enddate
    Click Continue