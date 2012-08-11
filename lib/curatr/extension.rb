module Curatr

  config.resources = {}
  
  def self.register(resource, options = {}, &block)
      
    resource.send(:include, Curatr::InstanceMethods)
    resource.send(:extend, Curatr::ClassMethods)
    
    @config = config.resources[resource.to_s.underscore] = YAML.load(File.read('config/curatr.yml'))['resources'][resource.to_s.underscore]
    
    instance_eval &block if block_given?
    
    resource.run
  
  end
  
  def self.fields(options = {})
    @config.merge!(options)
  end
  
  def self.automatically_publish
    @config[:autopublish] = true
  end
  
  module InstanceMethods
     
    def publish
      self.published = true
      self.save!
      # do we want to Tweet this?
    end
  
  end

  module ClassMethods
    
    require 'daemons'
               
    def config
      Curatr.config.resources[self.to_s.underscore]
    end
    
    def run
      
      attr_accessible :published
      
      daemon = Daemons.call(:multiple => true) do
        loop {
          self.fetch
          sleep 300
        }
      end
      
    end
                                        
    def fetch

      begin

        imap = Net::IMAP.new(config['email']['host'], config['email']['port'], true)
        imap.login(config['email']['username'], config['email']['password'])
        imap.select('Inbox')

        imap.uid_search(["NOT", "DELETED", "NOT", "SEEN"]).each do |uid|
          source = imap.uid_fetch(uid,['RFC822']).first.attr['RFC822']
          mail = Curatr::Mailer.receive(source)
          self.store(mail)
        end

      end

      imap.logout
      imap.disconnect

      # NoResponseError and ByResponseError happen often
      rescue Net::IMAP::NoResponseError => e
      rescue Net::IMAP::ByeResponseError => e
      rescue => e
      puts "Error: #{e.message}"

    end

     def store(mail)
                
        self.create!(
          config[:subject] || :subject => mail[:subject],
          config[:body] || :body => mail[:body],
          :published => config[:autopublish] || false
        )
        
        # notify sender that it's been put on the queue and...
        # notify admin if not autopublished
        
     end

  end
  
end