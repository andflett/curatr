module Curatr

  class Mailer < ActionMailer::Base
    
    def receive(source)
      
       if source.multipart?
         body = ActiveSupport::Multibyte::clean(source.parts[0].body.decoded)
       else
         body = ActiveSupport::Multibyte::clean(source.body.decoded)
       end
       
       { :subject => source.subject, :body => body }
        
    end
    
  end
  
end