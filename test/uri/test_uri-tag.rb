require 'test/unit'
require 'uri/tag'

module URI

class TestTag < Test::Unit::TestCase
  def setup
    @uri = URI.parse('tag:example.com,2000:')
  end

  def test_pattern
    assert_match /#{Tag::DNSNAME_PATTERN}/, 'sub-domain.example.net'
    assert_match /#{Tag::AUTHORITY_PATTERN}/, 'sub-domainexample.net'
    assert_match /#{Tag::AUTHORITY_PATTERN}/, 'admin+ml@sub-domainexample.net'
    assert_match /#{Tag::DATE_PATTERN}/, '2014'
    assert_match /#{Tag::DATE_PATTERN}/, '2014-05'
    assert_match /#{Tag::DATE_PATTERN}/, '2014-05-31'
  end

  def test_parse
    uri = URI.parse('tag:example.net,2014:specific?query#fragment')

    assert_equal 'tag', uri.scheme
    assert_equal 'example.net', uri.authority
    assert_equal '2014', uri.date
    assert_equal 'specific?query', uri.specific
    assert_equal 'fragment', uri.fragment
    assert_equal 'example.net,2014:specific?query', uri.opaque

    assert_nil uri.host
    assert_nil uri.path
    assert_nil uri.port
    assert_nil uri.query
    assert_nil uri.registry

    %w[
      tag:
      tag:example.net
      tag:example.net,2014
    ].each do |uri_str|
      assert_raise InvalidURIError do
        URI.parse uri_str
      end
    end
  end

  def test_build
    tag = nil
    assert_nothing_raised do
      tag = URI::Tag.build(['example.org', '2014', 'uri-tag', 'test'])
    end
    assert_equal 'example.org', tag.authority
    assert_equal '2014', tag.date
    assert_equal 'uri-tag', tag.specific
    assert_equal 'test', tag.fragment
    assert_equal 'example.org,2014:uri-tag', tag.opaque
    assert_equal 'tag:example.org,2014:uri-tag#test', tag.to_s
  end

  def test_compopnent
    assert_equal [:scheme, :authority, :date, :specific, :fragment], @uri.component
  end

  def test_authority
    [
      '',
      ' exapmle.net '
    ].each do |authority|
      assert_raise InvalidComponentError do
        @uri.authority = authority
      end
    end
  end

  def test_date
    %w[
      20
      2014/06/04
      2014-06-04T00:00
    ].each do |date|
      assert_raise InvalidComponentError do
        @uri.date = date
      end
    end
  end

  def test_specific
    @uri.specific = 'sp%20+'
    assert_equal 'sp%20+', @uri.specific
    assert_raise InvalidComponentError do
      @uri.specific = '#frag'
    end
    assert_equal '', URI.parse('tag:example.net,2000:').specific
  end

  def test_opaque
    @uri.fragment = 'frag'
    @uri.opaque = 'example.org,2015:speci?fic'
    assert_equal 'example.org,2015:speci?fic', @uri.opaque
    assert_equal 'example.org', @uri.authority
    assert_equal '2015', @uri.date
    assert_equal 'speci?fic', @uri.specific
    assert_equal 'frag', @uri.fragment
    [
      nil,
      ''
    ].each do |str|
      assert_raise InvalidURIError do
        @uri.opaque = nil
      end
    end
  end

  def test_fragment
    assert_raise InvalidComponentError do
      @uri.fragment = 'sp ce'
    end
  end

  def test_port
    assert_nil @uri.default_port
    assert_raise InvalidURIError do
      @uri.port = 80
    end
  end

  def test_equal
    assert(URI.parse('tag:example.com,2000:') == URI.parse('tag:example.com,2000:'))
    assert(URI.parse('tag:example.com,2000:') != URI.parse('tag:EXAMPLE.COM,2000:'))
    assert(URI.parse('tag:example.com,2000:') != URI.parse('tag:example.com,2000-01-01:'))
  end

  def test_date_to_time
    assert_instance_of Time, @uri.date_to_time
    assert @uri.date_to_time.utc?
    assert_equal Time.new(2000, 1, 1, 0, 0, 0, '+00:00'), @uri.date_to_time
  end
end

end
