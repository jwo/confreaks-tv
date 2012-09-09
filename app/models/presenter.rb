class Presenter < ActiveRecord::Base
  has_many :presentations
  has_many :videos, :through => :presentations, :order => 'recorded_at desc'

  has_one :user

  has_one :most_recent_video,
    :class_name => 'Video',
    :through => :presentations,
    :order => 'recorded_at desc'

  validates :first_name, :uniqueness => {:scope => :last_name}

  def to_param
    "#{id}-#{slug}"
  end

  def slug
    display_name.gsub('.','').strip.gsub(' ','-').gsub("'",'').downcase
  end

  def display_name
    parts = []
    
    parts << first_name
    parts << last_name

    parts.join(" ")
  end

  def twitter_name
    if twitter_handle
      twitter_handle.gsub("@", "")
    end
  end

  def events
    videos.collect {|video| video.event}.uniq
  end

  def avatar_url(options={})
    unless user.nil?
      if user.avatar.url =~ /missing/
        user.gravatar_url(options)
      else
        user.avatar.url(options[:avatar_zie])
      end
    end
  end
end
