require 'minitest_helper'

class VideoTest < MiniTest::Rails::ActiveSupport::TestCase

  def test_requires_attributes
    video = Video.new

    assert video.invalid?, "record was valid... wtf?"
    
    assert video.errors.include?(:title),
      "title was not in the error set"
    assert video.errors.include?(:recorded_at),
      "recorded_at was not in the error set"
  end

  def test_has_specified_associations
    video = Video.new

    # Associations - has_many
    assert video.respond_to? :assets 
    assert video.respond_to? :presentations
    assert video.respond_to? :presenters
    assert video.respond_to? :available

    # Associations - belongs_to
    assert video.respond_to? :event
    assert video.respond_to? :streaming_video
    
    # special attributes
    assert video.respond_to? :per_page
    assert video.respond_to? :image
  end

  def test_has_specified_scopes
    assert Video.respond_to? :available, "video did not respond to available"
  end
  
  def test_license_url_works_for_supported_licenses
    v = Video.new

    assert_equal "http://creativecommons.org/licenses/by-sa/3.0/",  v.license_url,
    "default license_url returned an unexpected value"

    Video::LICENSES.each do |license|
      v = Video.new
      v.license = license

      refute v.license_url.nil?, "'#{license}' returns a nil license_ulr"
    end
  end

  def test_license_image_file_url
    v = Video.new

    assert_equal "http://i.creativecommons.org/l/by-sa/3.0/80x15.png", v.license_image_file_url, "default license_image_file_url returned an unexpected value"

    Video::LICENSES.each do |license|
      v=Video.new
      v.license = license

      refute v.license_image_file_url.nil?, "'#{license}' returns a nil license_image_file_url"
    end
  end
  
  def test_search
  end

  def test_random
  end

  
end
