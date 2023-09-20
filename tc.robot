
*** Settings ***
Library           SeleniumLibrary

*** Variables ***

${ApplicationURL}     https://www.bt.com/
${ExpectedTitle}      SIM Only Deals | Compare SIMO Plans & Contracts | BT Mobile
${expected_combined_discounts}       30% off and double data was 125GB 250GB Essential Plan was £27 £18.90 Per month
${my_element}         xpath://span[text()="Mobile"]/ancestor::li[@class="bt-navbar-screen-sm-main"]

*** Keywords ***

Open BT Website

    Open Browser    ${ApplicationURL}    Chrome
    Maximize Browser Window
    Sleep    5s
    Select Frame        //iframe[@name="trustarc_cm"]
    Click Element       //a[text()="Accept all cookies"]
    Sleep    10s
    Unselect Frame

Navigate to Mobile Phone

    Wait Until Page Contains Element    ${my_element}       10s
    Mouse Over           ${my_element}
    Sleep    10s
    Click Element       (//a[text()="Mobile phones"])[1]

Verify Banners Count

    Wait Until Page Contains    See handset deals
    ${banner_count} =    Get Element Count    xpath://div[@class="flexpay_flexpaycard_container__GnRx9"]/div[@class="flexpay-card_card_wrapper__Antym"]
    Should Be True    ${banner_count} >= 3

Scroll Down and Click SIM Only Deals

    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    8s
    Click Element    xpath://a[text()="View SIM only deals"]
    
Validate Page Title

    ${title} =    Get Title
    Log To Console    ${title}
    Should Be Equal As Strings    ${title}    ${ExpectedTitle}

Validate Discount Text

    ${discount1} =    Get Text    xpath:(//div[@class="simo-card-ee_social_norm__3lfdT"])[10]
    Log To Console    ${discount1}
    ${discount2} =    Get Text    xpath:(//span[@class="simo-card-ee_was_data__37BKi"])[7]
    Log To Console    ${discount2}
    ${discount3} =    Get Text    xpath:(//div[@class="simo-card-ee_pricing__3fYly"])[19]
    Log To Console    ${discount3}
    ${discount4} =    Get Text    xpath:(//span[text()="Essential Plan"])[4]
    Log To Console    ${discount4}
    ${discount5} =    Get Text    xpath:(//span[@class="simo-card-ee_was_pricing__3TyeL"])[9]
    Log To Console    ${discount5}
    ${discount6} =     Get Text   xpath:(//div[@class="simo-card-ee_pricing__3fYly"])[20]
    Log To Console    ${discount6}
    ${discount7} =    Get Text    xpath:(//span[text()="Per month"])[10]
    Log To Console    ${discount7}

    ${actual_combined_discounts} =    Catenate    ${discount1}    ${discount2}    ${discount3}    ${discount4}    ${discount5}    ${discount6}    ${discount7}

     Log To Console    Actual Combined Discounts: ${actual_combined_discounts}
     Log To Console    Expected Combined Discounts: ${expected_combined_discounts}
     Should Be Equal    ${actual_combined_discounts}    ${expected_combined_discounts}

Close BT Website
    Close Browser

*** Test Cases ***

Automate_BT_Com_Test

    Open BT Website

    Navigate to Mobile Phone

    Verify Banners Count

    Scroll Down and Click SIM Only Deals

    Validate Page Title

    Validate Discount Text
    Close BT Website