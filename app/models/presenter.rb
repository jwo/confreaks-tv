class Presenter < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  
  has_many :presentations
  has_many :videos, :through => :presentations, :order => 'recorded_at desc'
  has_many :links, :as => :linkable
  
  has_one :user

  validates :first_name, :uniqueness => {:scope => :last_name}

  belongs_to :favorite_video, :class_name => 'Video'

  def most_recent_video
    self.videos.first
  end
  
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

  def featured_video
    self.favorite_video || self.most_recent_video
  end
end
