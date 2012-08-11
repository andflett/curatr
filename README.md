# Curatr

Email/POST/Twitter -> ActiveRecord -> Manual Curation/Publishing -> Twitter

## Install

``` ruby
rails generate curatr:extension ModelName
```

### Config

- mail server YML

- Overwrite classmethods in your model, something like:

	def store(mail)
		puts #{mail.inspect}
	end

- Or to just change the fields content is saved to in your initializer:

	fields :subject => :title, :body => :description