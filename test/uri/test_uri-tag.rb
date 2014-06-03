require 'test/unit'
require 'uri/tag'

module URI

class TestTag < Test::Unit::TestCase
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
  end

  def test_split
    skip
  end

  def test_extract
    skip
  end

  def test_route_from
    skip
  end
end

end
