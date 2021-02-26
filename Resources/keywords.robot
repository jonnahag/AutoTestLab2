*** Settings ***
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime

*** Keywords ***
Get todays date
    ${TODAYS_DATE}            Get Current Date    result_format=%Y-%m-%d

Begin Web Test
    Open browser            about:blank     ${BROWSER}

Go To Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go to                       ${URL}

Verify Page Loaded
    Wait until page contains    Infotiv Car Rental

G

Verify startdate is today's date

    #${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${start_date}               Get value    id=start
    Should Be Equal	            "${TODAYS_DATE}"     "${start_date}"

Verify enddate is today's date
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${start_date}               Get value    id=end
    Should Be Equal	            "${todays_date}"     "${start_date}"

Choose startdate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${chosen_start_date}        Add Time to Date    ${todays_date}  1 days     result_format=%Y-%m-%d
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      ${chosen_start_date}
    Set Selenium Implicit Wait  5 seconds
    Verify chosen startdate     ${chosen_start_date}

Verify chosen startdate
    [Arguments]                 ${chosen_start_date}
    ${actual_start_date}        Get value      id=start
    Should be equal             "${chosen_start_date}"    "${actual_start_date}"

Choose enddate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${chosen_end_date}          Add Time to Date    ${todays_date}  2 days     result_format=%Y-%m-%d
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}
    Verify chosen enddate       ${chosen_end_date}

Verify chosen enddate
    [Arguments]                 ${chosen_end_date}
    ${actual_end_date}          Get value      id=end
    Should be equal             "${chosen_end_date}"    "${actual_end_date}"

Click Continue
    Click button                id:continue
    Verify Right Page

Verify Right Page
    ${actual_text}              Get text    id:questionText
    Should be equal             "${actual_text}"   "What would you like to drive?"

Verify not able to continue
    ${actual_text}              Get text    id:questionText
    Should not be equal         "${actual_text}"   "What would you like to drive?"

Verify startdate max 1 month ahead
    ${todays_date}                  Get Current Date    result_format=%Y-%m-%d
    ${datetime}                     Convert date    ${todays_date}      datetime
    Should be equal as integers     ${datetime.month}   2
    ${add_1month}                   Evaluate     $datetime.month+1
    Should be equal as integers     ${add_1month}   3
    ${max_date}                     Get Current Date    result_format=%Y-%00${add_1month}-%d
    ${over_max_date}                Add Time to Date    ${max_date}  1 days     result_format=%Y-%m-%d

    Should be equal                 "2021-03-26"    "${max_date}"
    Should be equal                 "2021-03-27"    "${over_max_date}"

End Web Test
    Close browser

