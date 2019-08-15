Feature: browser automation

  Background:

#    * configure driver =  { type: 'chromedriver', port: 9515, showDriverLog: true, executable: 'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe' }
    * configure driver = { type: 'chrome', showDriverLog: true }
#    * configure driver =  { type: 'Firefox', port: 4444, showDriverLog: true, executable:'C:\MyDrivers\geckodriver.exe'}

   # * configure driver = { type: 'geckodriver', showDriverLog: true }
   # * configure driver = { type: 'safaridriver' }
   # * configure driver = { type: 'mswebdriver' }
    
    * def FirstName = "#firstname-ed298fe5-93e3-4ff5-8768-56735d56aea9"
    
  * def sleepy =
    """
    function(pause){java.lang.Thread.sleep(pause)}
    """

  Scenario: try to login to github and then do a google search
    Given driver 'https://github.com/login'
    And driver.input('#login_field', 'hello')
    And driver.input('#password', 'world')
    When driver.submit("input[name=commit]")
    Then match driver.html('#js-flash-container') contains 'Incorrect username or password.'

    Given driver 'https://google.com'
    And driver.input("input[name=q]", 'karate dsl')
    When driver.submit("input[name=btnI]")
    * def location = driver.location
    Then match location == 'https://github.com/intuit/karate'

    * def bytes = driver.screenshot()
    * karate.embed(bytes, 'image/png')
    #call API in the same file
    When def results = callonce read('classpath:API/APITest.feature')

    * json results  = $results.response
    And print results

#    Scenario: calling api#call API in the same file
#      * def results = callonce read('classpath:API/APITest.feature')
#      * json results  = $results.response
#      And print results


    Scenario: Test hrm
      * callonce sleepy 2000
      Given driver 'https://www.orangehrm.com/'
      * driver.waitUntil("document.readyState == 'complete'")
      And driver.click("//a[@class='optanon-allow-all accept-cookies-button']",true)
      * def bytes = driver.screenshot()
      * karate.embed(bytes, 'image/png')
      And driver.focus("//a[contains(@class,'btn-orange ohrm-grow om-btn om-demo')]")
      And driver.click("//a[contains(@class,'btn-orange ohrm-grow om-btn om-demo')]",true)
      And match driver.text('#modal-title') == 'Request An Enterprise Demo'
      And print " And user enters username"
      * driver.input(FirstName, 'test input', true)
      * driver.input("#lastname-ed298fe5-93e3-4ff5-8768-56735d56aea9", 'test input', true)
      * driver.input("#jobtitle-ed298fe5-93e3-4ff5-8768-56735d56aea9", 'test input', true)
      * driver.input("#company-ed298fe5-93e3-4ff5-8768-56735d56aea9", 'test input', true)
      * driver.input("#email-ed298fe5-93e3-4ff5-8768-56735d56aea9", 'testing@test.com', true)
      * driver.input("#phone-ed298fe5-93e3-4ff5-8768-56735d56aea9", '03155555', true)
      And driver.value("#numemployees-ed298fe5-93e3-4ff5-8768-56735d56aea9",'21 - 25')
      And driver.select("#country-ed298fe5-93e3-4ff5-8768-56735d56aea9", '')
      And driver.select("#country-ed298fe5-93e3-4ff5-8768-56735d56aea9", 11)
      And driver.click("#country-ed298fe5-93e3-4ff5-8768-56735d56aea9")
      * callonce sleepy 1000
      And driver.click("//input[@class='hs-button primary large']")
      And driver.submit("//input[@class='hs-button primary large']")
      * callonce sleepy 1000
      And def thankstext = driver.text("//p[contains(text(),'Thank you!')]")
#      And match thankstext == 'Thank you!'
      * callonce sleepy 1000
      * def bytes = driver.screenshot()
      * karate.embed(bytes, 'image/png')






