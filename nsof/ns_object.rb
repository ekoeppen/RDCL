require 'rdcl/nsof/nsof.rb'
require 'rdcl/utils/unicode.rb'

module RDCL
  
  class NSObject

    attr_accessor :ns_class
    attr_accessor :value

    def to_s
      return @value
    end
    
    def from_nsof(b, factory)
      factory.objects << self
    end
    
  end

end