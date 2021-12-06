@smoke
Feature: Bitwise operator testcases

  Background:
    * url hostUrl
    * header Authorization = call read('../basic-auth.js') { username: '#(username)', password: '#(password)' }
    * configure retry = {count:20, interval:1000}

  Scenario Outline: Groovy code with & operator and validate response

    Given path postUrl
    * def payload = read('../logicaltestscenarios/data/logicaloperatordata.json')
    * payload.code = "<a> & <b>"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "<a> & <b>"
    Examples:
      |a|b|
      |0|0|
      |0|1|
      |1|0|
      |1|1|

  Scenario Outline: Groovy code with | operator and validate response

    Given path postUrl
    * def payload = read('../logicaltestscenarios/data/logicaloperatordata.json')
    * payload.code = "<a> | <b>"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "<a> | <b>"
    Examples:
      |a|b|
      |0|0|
      |0|1|
      |1|0|
      |1|1|

  Scenario Outline: Groovy code with ^ operator and validate response

    Given path postUrl
    * def payload = read('../logicaltestscenarios/data/logicaloperatordata.json')
    * payload.code = "<a> ^ <b>"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "<a> ^ <b>"
    Examples:
      |a|b|
      |0|0|
      |0|1|
      |1|0|
      |1|1|
  Scenario Outline: Groovy code with ~ operator and validate response

    Given path postUrl
    * def payload = read('../logicaltestscenarios/data/logicaloperatordata.json')
    * payload.code = "~<a>"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "~<a>"
    Examples:
      |a|
      |0|
      |1|

