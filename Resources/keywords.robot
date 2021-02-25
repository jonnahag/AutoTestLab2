*** Settings ***
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime

*** Keywords ***
Begin Web Test
    Open browser            about:blank     ${BROWSER}

Go To Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go to                       ${URL}

Verify Page Loaded
    Wait until page contains    Infotiv Car Rental

Verify startdate is today's date
    ${start_date}               Get value    id=start
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    Should Be Equal	            "${todays_date}"     "${start_date}"

Verify enddate is today's date
    ${start_date}               Get value    id=end
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    Should Be Equal	            "${todays_date}"     "${start_date}"

Choose startdate
    [Arguments]                 ${chosen_start_date}
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      ${chosen_start_date}
    Set Selenium Implicit Wait  5 seconds

Verify chosen startdate
    [Arguments]                 ${chosen_start_date}
    ${actual_start_date}        Get value      id=start
    Should be equal             "${chosen_start_date}"    "${actual_start_date}"

Click Continue
    Click element                id:continue

Verify Right Page
    Wait until page contains    "What would you like to drive?"
    ${dates_correct}            Get text    //*[@id="showQuestion"]/label
    Should be equal             "Selected trip dates: 2021-03-03 – 2021-03-05"  "${dates_correct}"




Try choose earlier date
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      0222
    Set Selenium Implicit Wait  5 seconds






Choose enddate
    [Arguments]                 ${chosen_end_date}
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}    RETURN
    Set Selenium Implicit Wait  5 seconds

Verify chosen enddate
    [Arguments]                 ${chosen_end_date}
    ${actual_end_date}          Get value      id=end
    Should be equal             "${chosen_end_date}"    "${actual_end_date}"

End Web Test
    Close browser

