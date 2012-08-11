module Curatr

  config.resources = {}
  
  def self.register(resource, options = {}, &block)
      
    resource.send(:include, Curatr::InstanceMethods)
    resource.send(:extend, Curatr::ClassMethods)
    
    @config = config.resources[resource.to_s.underscore] = YAML.load(File.read('config/curatr.yml'))['resources'][resource.to_s.underscore]
    
    instance_eval &block if block_given?
  
  end
  
  def self.fields(options = {})
    @config.merge!(options)
  end
  
  module InstanceMethods
     
    def publish
      puts "#{self.inspect}" # do we want to Tweet this?
    end
  
  end

  module ClassMethods
                     
    def config
      Curatr.config.resources[self.to_s.underscore]
    end
                                                
    def receive

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

      # expunge removes the deleted emails
      imap.expunge
      imap.logout
      imap.disconnect

      # NoResponseError and ByResponseError happen often when imap'ing
      rescue Net::IMAP::NoResponseError => e
      rescue Net::IMAP::ByeResponseError => e
      rescue => e
      puts "Error: #{e.message}"

    end

     def store(mail)
                
        self.create!(
          config[:subject] || :subject => mail[:subject],
          config[:body] || :body => mail[:body]
        )
        
        # if queue, add queued flag to instance - need generated migration for this
        # make sure to notify admin by email if not putting on queue for auto publishing
        
     end

     def publish_queue
       #@instances = self.find_all_by_queued(true)
       #@instances.each do |instance|
       #  instance.publish
       #end
     end

  end
  
end