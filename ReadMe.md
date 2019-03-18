## A CLI built using Ruby that allows users to:
. enter urls via the command line
. upload urls via csv file
. or json format and store and return screenshots of the urls.

## How to start
. Clone this repo
. *bundle install* all of the gems within the gemfile
. move to home directory for the files and run ruby app.rb

## Functionality
. First register an account
. Login
. save screenshots of urls Ð option 2
. option 1 enter urls from CLI
. option 2 upload urls from csv file
. option 3 upload urls from json file
. retrieve saved screenshots at any time option 3

## Format expected for csv or json files

### CSV
. Only urls with no headers should be uploaded - example below:
	http://www.youtube.com
  	http://www.facebook.com

### JSON
. Ensure that you have a key ÒurlsÓ and you store your urls within the values example below:
{
  "urls": {
    "google": "https://www.google.com",
    "wikapedia": "https://www.wikapedia.com"
  }
}

## Scaling
Parse and screenshot methods have been built in a separate group to enable scalability. For production I would not use SQLIte3 but Postgres or MySQL.







