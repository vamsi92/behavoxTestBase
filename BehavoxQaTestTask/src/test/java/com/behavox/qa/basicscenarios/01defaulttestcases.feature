@smoke
Feature: Basic initial scenarios for groovy code evaluator api

  Background:
    * url hostUrl
    * header Authorization = call read('../basic-auth.js') { username: '#(username)', password: '#(password)' }
    * configure retry = {count:20, interval:1000}

  Scenario: Hit the api service by providing null for groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    And request payload
    When method POST
    Then status 400

  Scenario: Hit the api service by providing 'null' for groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = 'null'
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "null"

  Scenario: Hit the api service by providing '' for groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = ''
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == null

  Scenario: Hit the api service by providing empty payload and validate the response
    Given path postUrl
    * def payload = {}
    And request payload
    When method POST
    Then status 400

  Scenario: Hit the api service twice with the same payload for groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '3+5'
    And request payload
    When method POST
    Then status 200
    And request payload
    When method POST
    Then status 200

  Scenario: Hit the api service with addition of two numbers for groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '6+6'
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '12'

  Scenario: Hit the api service with invalid groovy code and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = 'abc'
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "FAILED"
    Then retry until response.result contains 'No such property'

  Scenario: Groovy code with numbers as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = '123456'
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "123456"

  Scenario: Groovy code with println statement as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = "println 'sample'"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "null"

  Scenario: Groovy code with return statement as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = "return 'example'"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "example"

  Scenario: Groovy code with only main method as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/mainmethodpayload.json')
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "null"

  Scenario: Groovy code with  main method and a static method as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/staticandmainmethodpayload.json')
    And request payload
    When method POST
    Then status 500

  Scenario: Groovy code with only static method as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/staticmethodonlypayload.json')
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "null"

  Scenario: Groovy code with same class name and different body as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/mainmethodpayload1.json')
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "null"

  Scenario: Groovy code with range operator as payload and validate the response
    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = 'def range = 5..10; range.get(2);'
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '7'

  Scenario Outline: Groovy code with string concat and validate response

    Given path postUrl
    * def payload = read('../basicscenarios/data/defaulttestcasesdata.json')
    * payload.code = "'<a>' + '<b>'"
    And request payload
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == "'<a>' + '<b>'"
    Examples:
      |a|b|
      |Hello|World|
      |Test|Sample|
