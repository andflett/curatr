# Curatr

Email/POST/Twitter -> ActiveRecord -> Manual Curation/Publishing -> Twitter

## Install

``` bash
rails generate curatr:extension ModelName
rake db:migrate
```

### Config

Edit mail server YML

#### (optional) Change the fields content is saved to in your initializer:

    fields :subject => :title, :body => :description

#### (optional) Overwrite class methods in your model

    def store(mail)
      puts #{mail.inspect}
    end

### Running

Each model will run a deamon to fetch emails from the server and parse them. If you wish to manually fetch:

    ModelName.fetch

Entries will have to be manually published unless:

    Curatr.register ModelName do
 
      automatically_publish
             
    end