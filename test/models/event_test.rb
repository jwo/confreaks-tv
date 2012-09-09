require "minitest_helper"

class EventTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_required_attributes
    event = Event.new

    assert event.invalid?, "record was valid... wtf?"
    assert event.errors.include?(:short_code),
      "short_code was not in the error set"
  end

  def test_has_specified_associations
    event = Event.new

    assert event.respond_to?(:conference),        "event did not respond to conference"
    assert event.respond_to?(:videos),            "event did not respond to videos"
    assert event.respond_to?(:videos_posted),     "event did not respond to videos_posted"
    assert event.respond_to?(:available_videos),  "event did not respond to available_videos"
    assert event.respond_to?(:available_videos_posted),
      "event did not respond to available_videos_posted"
    assert event.respond_to?(:logo)
    
  end

  def test_has_specified_scopes
    assert Event.respond_to? :active, "event did not respond to active"
  end

  def test_to_param
    event = Event.new
    event.short_code = "juc2012"
    
    assert event.save, "failed to save event"

    assert_equal "juc2012", event.to_param
    
  end

  def test_find_by_identifier
    event = Event.new

    event.short_code = "juc2012"
    assert event.save

    result = Event.find_by_identifier("juc2012")

    assert_equal event, result
  end

  def test_display_name
    conference = Conference.new
    conference.name = "RubyConf"

    assert conference.save

    event = Event.new
    event.name_suffix = "2012"
    event.name_prefix = "The"
    event.short_code = "ihazone"
    event.conference = conference
    
    assert event.save
    
    assert_equal "The RubyConf 2012", event.display_name
  end

  def test_display_name_strips_spaces
    conference = Conference.new
    conference.name =  " testing "

    assert conference.save

    event = Event.new
    event.name_suffix = " suffix "
    event.name_prefix = " prefix "
    event.short_code = "sc"
    event.conference = conference
    
    assert event.save

    assert "prefix testing suffix", event.display_name
  end

  def test_date_occurred
    event = Event.new
    event.short_code = "datecheck"

    # if start_at and end_at are nil, the date_occured should be blank
    assert_equal "", event.date_occurred

    event.start_at = "2012-06-10"
    # if start_at is set, but end_at is not
    assert_equal "Jun 10, 2012", event.date_occurred
    
    event.end_at = "2012-06-12"
    # if start_at and end_at have values in same month
    assert_equal "Jun 10 - 12, 2012", event.date_occurred

    event.start_at = nil
    # if start_at is nil and end_at is populated
    assert_equal "Jun 12, 2012", event.date_occurred

    event.start_at = "2012-05-31"
    # if event starts and ends in different months
    assert_equal "May 31 - Jun 12, 2012", event.date_occurred
  end
  
end
