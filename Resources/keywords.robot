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

Choose enddate
    [Arguments]                 ${chosen_end_date}
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}

Verify chosen enddate
    [Arguments]                 ${chosen_end_date}
    ${actual_end_date}          Get value      id=end
    Should be equal             "${chosen_end_date}"    "${actual_end_date}"

Click Continue
    Click button                id:continue

Verify Right Page
    [Arguments]                 ${correct_start_date}   ${correct_end_date}
    Wait until page contains    What would you like to drive?
    ${dates_correct}            Get text    //*[@id="showQuestion"]/label
    Should be equal             "Selected trip dates: ${correct_start_date} – ${correct_end_date}"  "${dates_correct}"

Verify not able to continue
    ${actual_text}              Get text    id:questionText
    Should not be equal         "${actual_text}"   "What would you like to drive?"

Verify startdate max 1 month ahead
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    #${max_date}                Add Time to Date    ${todays_date}  30 days     result_format=%Y-%m+1-%d
    ${datetime}                 Convert date    ${todays_date}      datetime
    Should be equal as integers     ${datetime.month}   2
    ${max_date}                 ${datetime.month(+1)}
    Should be equal as integers     ${max_date}   3


    #Should be equal             "2021-03-25"    "${max_date}"


End Web Test
    Close browser

