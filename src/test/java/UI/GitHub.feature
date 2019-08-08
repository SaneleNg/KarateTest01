Feature: browser automation

  Background:

#    * configure driver =  { type: 'chromedriver', port: 9515, showDriverLog: true, executable: 'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe' }
    * configure driver = { type: 'chrome', showDriverLog: true }
   # * configure driver = { type: 'geckodriver', showDriverLog: true }
   # * configure driver = { type: 'safaridriver' }
   # * configure driver = { type: 'mswebdriver' }
  * def webUrlBase = 'https://github.com/login'

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
    * def results = callonce read('classpath:API/APITest.feature')
    * json results  = $results.response
    And print results

