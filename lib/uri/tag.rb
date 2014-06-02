require 'uri/generic'

module URI
  class Tag < Generic
    COMPONENT = [:scheme, :authority, :date, :specific, :fragment].freeze

    DNSCOMP_PATTERN = "(?:[#{PATTERN::ALNUM}](?:[#{PATTERN::ALNUM}|\\-]*[#{PATTERN::ALNUM}])?)".freeze
    DNSNAME_PATTERN = "(?:#{DNSCOMP_PATTERN}(?:\\.#{DNSCOMP_PATTERN})*)".freeze
    AUTHORITY_PATTERN = "(?:[#{PATTERN::ALNUM}|\\-\\._]+@)?#{DNSNAME_PATTERN}".freeze
    DATE_PATTERN = '\d{4}(?:\-\d{2}(?:\-\d{2})?)?'.freeze
    UNRESERVED_PATTERN = "#{PATTERN::ALNUM}\\-\\._~".freeze
    SUB_DELIMS_PATTERN = '!$&\'\(\)*+,;='.freeze
    PCHAR_PATTERN = "#{UNRESERVED_PATTERN}#{PATTERN::ESCAPED}#{SUB_DELIMS_PATTERN}:@".freeze
    SPECIFIC_PATTERN = "[#{PCHAR_PATTERN}/?]*".freeze
    TAG_REGEXP = Regexp.new("
      \\A
      (?<authority>#{AUTHORITY_PATTERN})
      ,
      (?<date>#{DATE_PATTERN})
      :
      (?<specific>#{SPECIFIC_PATTERN})
      \\z
    ", Regexp::EXTENDED).freeze

    attr_reader :authority, :date, :specific, :fragment

    def initialize(*arg)
      super(*arg)

      if TAG_REGEXP =~ @opaque
        self.authority = $~['authority']
        self.date = $~['date']
        self.specific = $~['specific']
      end
    end

    def tagging_entity
      authority + ',' + date
    end

    def authority=(value)
      @authority = value
    end

    def date=(value)
      @date = value
    end

    def specific=(value)
      @specific = value
    end

    def fragment=(value)
      @fragment = value
    end
  end

  @@schemes['TAG'] = Tag
end
