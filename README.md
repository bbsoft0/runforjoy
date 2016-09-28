## Run For Joy

A cute application offering stats and advice for joyfull and healthy running.

Values elegance, simplicity, and readability.

Contains data from multiple competitions (segments).

General statistics for all runners -  stars - personal bests.

## Demo

An online <a href="http://runforjoy.herokuapp.com/">version </a> is available.


## Implementation Features

 * Authentication with devise
 * Facebook authentication
 * RSpec Testing
 * Capybara Web Testing
 * Best practices
 * Ajax Search
 * Graphs
 * Upload Results File (CSV)

## Application Usage
 Make an account - entering your data or use Sign In with Facebook

 Enter your segments - competitions you participated

 Upload the Results file for the competition (using csv format)

 the header of csv file should start with this line:
 place,name,company,time

 company field is optional (blank can be put in data)

  Spreadsheet like LibreOffice / Excel have the export to CSV functionality that can be used.


## Issues, questions and feature requests
Open a new issue, I'd love to help.


## Future TODOs ideas

1) Parsing data directly from sites using Resque background worker

2)Display Strengths and weaknesses
   See actual form - long term health focus

3) Add Badges

4) Restful API


