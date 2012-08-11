require "active_support/dependencies"
require 'net/imap'
require 'net/http'

module Curatr

	mattr_accessor :app_root

  module Helpers
    autoload :FormBuilder, 'curatr/helpers/form_builder'
    autoload :FormHelper, 'curatr/helpers/form_helper'
  end
  
  def self.setup
  	yield self
  end
  
end

require "curatr/engine"
require "curatr/mailer"
require "curatr/extension"
