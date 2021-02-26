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

Verify startdate is today's date
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${start_date}               Get value    id=start
    Should Be Equal	            "${todays_date}"     "${start_date}"

Verify enddate is today's date
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${start_date}               Get value    id=end
    Should Be Equal	            "${todays_date}"     "${start_date}"

Choose startdate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_start_date}        Add Time to Date    ${todays_date}  5 days     result_format=%m-%d
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      ${chosen_start_date}
    Verify chosen startdate     ${getYear}-${chosen_start_date}

Verify chosen startdate
    [Arguments]                 ${chosen_start_date}
    ${actual_start_date}        Get value      id=start
    Should be equal             "${chosen_start_date}"    "${actual_start_date}"

Choose enddate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_end_date}          Add Time to Date    ${todays_date}  6 days     result_format=%m-%d
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}
    Verify chosen enddate       ${getYear}-${chosen_end_date}

Verify chosen enddate
    [Arguments]                 ${chosen_end_date}
    ${actual_end_date}          Get value      id=end
    Should be equal             "${chosen_end_date}"    "${actual_end_date}"

Click Continue
    Click button                id:continue

Verify Right Page
    ${actual_text}              Get text    id:questionText
    Should be equal             "${actual_text}"   "What would you like to drive?"

Verify not able to continue
    ${actual_text}              Get text    id:questionText
    Should not be equal         "${actual_text}"   "What would you like to drive?"

Choose too early startdate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_start_date}        Subtract Time From Date    ${todays_date}  4 days     result_format=%m-%d
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      ${chosen_start_date}
    Set Selenium Implicit Wait  5 seconds
    Verify chosen startdate     ${getYear}-${chosen_start_date}
    Verify not able to continue

Choose too early enddate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_end_date}          Subtract Time From Date    ${todays_date}  5 days     result_format=%m-%d
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}
    Verify chosen enddate       ${getYear}-${chosen_end_date}
    Verify not able to continue

Choose too late startdate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_start_date}        Add Time To Date    ${todays_date}  35 days     result_format=%m-%d
    Click element               xpath://*[@id="start"]
    Press keys                  xpath://*[@id="start"]      ${chosen_start_date}
    Verify chosen startdate     ${getYear}-${chosen_start_date}
    Verify not able to continue

Choose too late enddate
    ${todays_date}              Get Current Date    result_format=%Y-%m-%d
    ${getYear}                  evaluate   time.strftime("%Y")
    ${chosen_end_date}          Add Time To Date    ${todays_date}  35 days     result_format=%m-%d
    Click element               xpath://*[@id="end"]
    Press keys                  xpath://*[@id="end"]      ${chosen_end_date}
    Verify chosen enddate       ${getYear}-${chosen_end_date}
    Verify not able to continue

End Web Test
    Close browser




# Ett försöka att göra det helautomatiskt som inte riktigt funkar.
Verify startdate max 1 month ahead AUTOMATIC
    ${todays_date}                  Get Current Date    result_format=%Y-%m-%d
    ${datetime}                     Convert date    ${todays_date}      datetime
    Should be equal as integers     ${datetime.month}   2
    ${add_1month}                   Evaluate     $datetime.month+1
    Should be equal as integers     ${add_1month}   3
    ${max_date}                     Get Current Date    result_format=%Y-%00${add_1month}-%d
    ${over_max_date}                Add Time to Date    ${max_date}  1 days     result_format=%Y-%m-%d

    Should be equal                 "2021-03-26"    "${max_date}"
    Should be equal                 "2021-03-27"    "${over_max_date}"



