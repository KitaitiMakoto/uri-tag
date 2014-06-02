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

    def self.build(args)
      tmp = Util.make_components_hash(self, args)

      tmp[:opaque] = '' << tmp[:authority] << ',' << tmp[:date] << ':'

      if tmp[:specific]
        tmp[:opaque] << tmp[:specific]
      end

      if tmp[:fragment]
        tmp[:opaque] << '#' << tmp[:fragment]
      end

      return super(tmp)
    end

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
      set_authority(value)
      value
    end

    def date=(value)
      set_date(value)
      value
    end

    def specific=(value)
      set_specific(value)
      value
    end

    def fragment=(value)
      set_fragment(value)
    end

    protected

    def set_authority(authority)
      @authority = authority
    end

    def set_date(date)
      @date = date
    end

    def set_specific(specific)
      @specific = specific
    end
  end

  @@schemes['TAG'] = Tag
end
