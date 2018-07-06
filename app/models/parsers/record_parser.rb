module Parsers
  class RecordParser
    def self.parse(hash, options = {})
      new(hash, options).parse
    end

    def initialize(hash, options = {})
      @hash     = hash
      @options  = options
    end

    def parse
      record if record.update(attributes)
    end

    def klass
      raise NotImplementedError
    end

    def initialize_by
      raise NotImplementedError
    end

    def record
      klass.find_or_initialize_by(initialize_by)
    end

    def attributes
      @hash.select { |key, _| klass.column_names.include?(key.to_s) }
    end
  end
end
