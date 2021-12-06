Feature: This Feature has multiuser testcases

  Background:
    * url hostUrl
    * configure retry = {count:20, interval:1000}

  @multiusers
  Scenario: Hit the api service with user_1 and pass_1 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '900+1'
    * header Authorization = call read('../basic-auth.js') { username: 'user_1', password: 'pass_1' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '901'

  @multiusers
  Scenario: Hit the api service with user_2 and pass_2 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '900+2'
    * header Authorization = call read('../basic-auth.js') { username: 'user_2', password: 'pass_2' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '902'

  @multiusers
  Scenario: Hit the api service with user_3 and pass_3 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '900+3'
    * header Authorization = call read('../basic-auth.js') { username: 'user_3', password: 'pass_3' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '903'

  @multiusers
  Scenario: Hit the api service with user_4 and pass_4 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '900+4'
    * header Authorization = call read('../basic-auth.js') { username: 'user_4', password: 'pass_4' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '904'

  @multiusers
  Scenario: Hit the api service with user_5 and pass_5 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '900+5'
    * header Authorization = call read('../basic-auth.js') { username: 'user_5', password: 'pass_5' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '905'