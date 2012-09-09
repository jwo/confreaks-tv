require "minitest_helper"

class ConferenceTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_required_attributes
    conference = Conference.new

    assert conference.invalid?, "conference is valid, wtf?"
  end

  def test_required_associations
    conference = Conference.new

    assert conference.respond_to?(:events), "conference did not respond to events"
  end

  def test_to_param
    conference = Conference.new
    conference.name = "Ruby Conf"
    assert conference.save
    
    assert_match /-ruby-conf$/,  conference.to_param
  end

  def test_slug
    conference = Conference.new
    conference.name = "Ruby CONF"

    assert conference.save

    assert_match /-ruby-conf$/, conference.to_param

    conference.name = " RUBY CONF "
    # trailing and leading spaces should be disgarded and lowercase
    assert_match /-ruby-conf$/, conference.to_param
  end
end
