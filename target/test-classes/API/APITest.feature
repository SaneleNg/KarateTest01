Feature:

  Background:

  Scenario: test01
    Given url 'http://quotes.rest/qod/categories'
    When method get
    Then status 200
