# behavoxTestBase
# Instructions on how to use and execute the tests.

1. Clone this repository and import this project as a gradle project using preffered tool like IntelliJ/eclipse
2. Let the build execution be completed.
3. This project uses Karate API Framework and Cucumber will be the base.
4. Expand the project and you will see test subfolder in src folder.
5. Inside test/java there will be a package named com.behavox.qa
6. Inside this package the features are divided into respective packages.
   And inside these packages there will be feature files and respective data files
7. The feature files use Gherkin language
8. Inside com.behavox.qa you will see a TestRunner.java file.
9. Executing this file as a junit test will start the features execution in parallel.
10. There will also be a karate-config.js file which is responsible for initial setup like hosturl, username and password, etc.
    This uses basic javascript
11. Once the TestRunner completes its execution, The reports will be generated in target folder with karate-report
12. Inside the build.gradle file the gradle step was written in such a way that the project identifies where the feature files location available.