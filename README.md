# Welcome to Smartling Rails
SmartlingRails is a gem making localization with the [smartling](www.smartling.com) localization service easier in a ruby on rails environment. The Gem simplifies the uploading, status checking, and retrieval of information from smartling into a rails app that uses I18N localization.

Communication with smartling is done via their APIs and leverages the [smartling gem](https://rubygems.org/gems/smartling).

## overview
The uploading of [rials I18N](http://guides.rubyonrails.org/i18n.html) files to smartling, monitoring their translation status, and pulling them all back down into your `config/localization` folder is a very manual process.

We wanted to create a way to simplify the process of localization within our project workflow and automate as much of the process as possible.

This gem is a core part of that automation because it understands how to safely send I18N files to smarling and safely retrieve their translated counterparts back.

Translating files with smartling is now as easy a little configuration and two commands.


## usage

```
$> gem install smartling_rails
$> irb
-> require 'smartling_rails'
-> sr = SmartlingRails.processor

-> sr.get_file_statuses
Checking status for ["French fr-FR", "German de-DE", "Dutch nl-NL"]
fr-FR completed: false (158 / 161)
de-DE completed: true (161 / 161)
nl-NL completed: true (161 / 161)

-> sr.put_files
Uploading the english file to smartling to process:
uploading config/locales/en-us.yml to /files/[PROJECT_NAME]-[GIT_BRANCH_NAME]-en-us-.yml

-> sr.get_files
Checking status for ["French fr-FR", "German de-DE", "Dutch nl-NL"]

Downloading fr-FR:
file loaded...
Fixing Issues:
  fixing tabs from 4 spaces to 2 space
  removing space after branch root : \n to :\n
  remove "---" from first line
  yes, replaced dashes
  converting smartling locale code to CB locale code

Downloading de-DE:
file loaded...
Fixing Issues:
  fixing tabs from 4 spaces to 2 space
  removing space after branch root : \n to :\n
  remove "---" from first line
  yes, replaced dashes
  converting smartling locale code to CB locale code

Downloading nl-NL:
file loaded...
Fixing Issues:
  fixing tabs from 4 spaces to 2 space
  removing space after branch root : \n to :\n
  remove "---" from first line
  yes, replaced dashes
  converting smartling locale code to CB locale code

```

## structure
The smartling_rails gem consists of 3 components

**the Config class**
The config class loads and provides access for the configuration of the gem and how it interacts with your local application as well as the smartling APIs:
- **api_key** the api key for your smarling account
- **project_id** the smartling project id
- **locales** the hash of locales you support (locally and/or on smarlting)

**the SmartlingProcessor class**
The smartling processor class is responsible for defining the commands of the gem.  The ability to upload, download, and get status for the translations is done in this class.

**the SmartlingFile class**
The smartling file class is responsible for the processing of the smartling YAML response to correct a handful of YAML problems that occur when using Smartling's YAML service.  These include, removal of '---' from the file's first line, converting 4 spaces per tab to 2 spaces, removing misc spaces after nodes, converting smartling codes to local codes (if needed).


## configuration
The configuration of how smartling_rails processes information to/from your application and smarting is done in the following ways:

Local `.env` file
>SMARTLING_API_KEY=[your_smartling_api_key]
SMARTLING_PROJECT_ID=[your_project_id]

ENV (pending)
Yaml (pending)

## dependencies
smartling_rails is dependant on the [smartling gem](https://rubygems.org/gems/smartling) version 0.5.1 or higher. 

