module AgileZen
  class Base
    class << self
      # Builds and returns the Faraday::Connection based on set options.
      def connection
        @connection ||= Faraday::Connection.new(:url => connection_url, :headers => connection_headers) do |builder|
          builder.use Faraday::Response::ParseJson
          builder.use Faraday::Response::Mashify
          builder.adapter Faraday.default_adapter
        end
      end
  
      # Helper method for determining the correct URL.
      def connection_url
        'https://agilezen.com'
      end
  
      # Helper method for defining globally required headers.
      def connection_headers
        headers = {
          :accept => 'application/json',
          'X-Zen-ApiKey' => 'bffe4853b2e44f5289de81e040797cd5'
        }
      end
    end

    # Creates a new object of the given class based on the attributes passed in.
    def initialize(attributes={})
      define_attributes(attributes)
    
      attributes.each do |k, v|
        attr_sym = "#{k}=".to_sym
        self.send(attr_sym, v) if self.respond_to?(attr_sym)
      end
    end
  
    private
  
    # Builds attr_accessor for each attribute found in the reponse.
    def define_attributes(hash={})
      hash.each_pair do |key, value|
        self.class.send(:attr_writer, key) unless respond_to?("#{key}=".to_sym)
        self.class.send(:attr_reader, key) unless respond_to?("#{key}".to_sym)
      end
    end
  end
end