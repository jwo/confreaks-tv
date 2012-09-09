##
# this class represents an event
class Event < ActiveRecord::Base
  attr_accessible :short_code, :start_at, :end_at

  validates :short_code, :presence => true, :uniqueness => true
  
  scope :active,
    :conditions => ["display = ?", true],
    :order => 'start_at desc'

  belongs_to :conference

  has_many :videos, :order => 'recorded_at asc'

  has_many :videos_posted, :class_name => 'Video',
    :order => 'post_date desc'

  has_many :available_videos, :class_name => 'Video',
    :order => 'recorded_at asc', :conditions => ['available = ?', true]

  has_many :available_videos_posted, :class_name => 'Video',
    :order => 'post_date desc', :conditions => ['availabe = ?', true]
  
  has_attached_file :logo,
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename-:style.:extension",
    :url => "/system/:class/:attachment/:id/:basename-:style.:extension",
    :styles => {
      :tiny   => '50x50',
      :small  => '100x100',
      :medium => '200x200',
      :large  => '300x300',
      :xl     => '400x400',
      :xxl    => '500x500',
      :xxxl    => '600x600'
      },
    :default_url => '/system/:class/:attachment/missing-:style.png'

  ##
  # override default to_param so that events use the short_code in URLs
  def to_param
    short_code || id
  end

  ##
  # class method used to lookup by identifier, ie. id or short_code
  def self.find_by_identifier identifier
    unless identifier.to_i == 0
      find_by_id(identifier)
    else
      find_by_short_code(identifier)
    end
  end

  def display_name
    parts = Array.new
    parts << self.name_prefix.strip
    parts << self.conference.name.strip unless self.conference.nil?
    parts << self.name_suffix.strip

    parts.join(" ")
  end

  def date_occurred
    if start_at.nil?  && end_at.nil?
      ""
    elsif !start_at.nil?  && !end_at.nil?
      if start_at.strftime("%m").to_i == end_at.strftime("%m").to_i
        "#{start_at.strftime("%b %d")} - #{end_at.strftime("%d, %Y")}"
      else
        "#{start_at.strftime("%b %d")} - #{end_at.strftime("%b %d, %Y")}"
      end
    elsif !start_at.nil?
      start_at.strftime("%b %d, %Y")
    elsif !end_at.nil?
      end_at.strftime("%b %d, %Y")
    end
  end
end
