@smoke
Feature: This Feature has no auth or invalid auth related testcases

  Background:
    * url hostUrl
    * configure retry = {count:20, interval:1000}

  Scenario: Hit the api service with addition of two numbers for groovy code and no authentication provided  and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '8+8'
    And request payload
    When method POST
    Then status 401

  Scenario: Hit the api service with addition of two numbers for groovy code with and without authentication provided  and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '10+10'
    * header Authorization = call read('../basic-auth.js') { username: '#(username)', password: '#(password)' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '20'

    Given path postUrl
    * def payload2 = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload2.code = '15+10'
    And request payload2
    When method POST
    Then status 401

  Scenario: Hit the api service with addition of two numbers for groovy code with invalid authentication provided  and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '100+100'
    * header Authorization = call read('../basic-auth.js') { username: 'abc', password: 'abc' }
    And request payload
    When method POST
    Then status 401

  Scenario: Hit the api post service with addition of two numbers for groovy code with user_1/pass_1 and do a Get for the id with user_2/pass_2 validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '200+100'
    * header Authorization = call read('../basic-auth.js') { username: 'user_1', password: 'pass_1' }
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    * header Authorization = call read('../basic-auth.js') { username: 'user_2', password: 'pass_2' }
    When method GET
    Then status 401