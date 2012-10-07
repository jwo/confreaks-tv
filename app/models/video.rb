##
# the video object represents a video presentation from an event
class Video < ActiveRecord::Base
  attr_accessible :available, :title, :recorded_at, :event_id,
    :presentations_attributes, :assets_attributes, :include_random,
    :streaming_asset_id, :image, :abstract, :announce, :announce_date,
    :post_date, :note, :rating, :youtube_code, :license

  ##
  # the date that the video was put up on the site
  # :attr: post_date

  ##
  # this is a field for doing additional communication about the video
  # :attr: note

  ##
  # this ia rating based on the language of the video, see the RATINGS
  # constant for valid values for this attribute
  # :attr: rating

  ##
  # this is the video's identifier on youtube
  # :attr: youtube_code

  ##
  # this is the short identiifer for the license that this
  # presentation has been released under - see LICENSES for a list of
  # valid values
  # :attr: license
  
  ##
  # tells the system whether or not the video is ready for public
  # display
  # :attr: available

  ##
  # this is the title/name of the video and is used prominently for
  # display and identification, it typically comes from the name of
  # the presentation that was recorded
  # :attr: title

  ##
  # the date that the presenation/video was recorded in the real world
  # :attr: recorded_at

  ##
  # the id of event that this video belongs to
  # :attr: event_id

  ##
  # this attribute is used with the accept_nested_attributes and is
  # not persisted independently, it is in the attr_accessible list so
  # that things work the way they should
  # :attr: presentations_attributes

  ##
  # this attribute is used with the accept_nested_attributes and is
  # not persisted independently, it is in the attr_accessible list so
  # that things work the way they should
  # :attr: asset_attributes

  ##
  # this determines whether or not this video should be picked up by
  # the random method, if it meets all of the other requirements
  # :attr: include_random

  ##
  # this is the asset_id that should be used for the streaming
  # presentation, this is not used if the youtube_code is provided
  # :attr: streaming_asset_id

  ##
  # this is the thumbnail that is used with this video
  #
  # it is backed by paperclip
  # :attr: image

  ##
  # this is the name of the file the image is stored in
  # :attr: image_file_name

  ##
  # this is the content type of the image
  # :attr: image_content_type

  ##
  # size of the file that the image is stored in
  # :attr: image_file_size

  ##
  # the datetime that the image was last updated
  # :attr: image_updated_at
  
  ##
  # a brief introduction/description of the video
  # :attr: abstract

  ##
  # this is a boolean value that tells whether or not to announce the
  # video
  #
  # NOTE it is not yet being utilized
  # :attr: announce

  ##
  # this is the date that the video was announced, used to record when
  # an announcement took place, if the announce boolean is true
  #
  # NOTE not currently implemented
  # :attr: announce_date
  
  ##
  # requires title
  validates  :title, :presence => true

  ##
  # requires recorded_at date
  validates_presence_of :recorded_at

  ##
  # the event that this video belongs to
  belongs_to :event

  ##
  # the streaming_asset that is used for this video
  belongs_to :streaming_video,
             :class_name => 'Asset',
             :foreign_key => "streaming_asset_id"

  has_many :list_entries
  has_many :lists, :through => :list_entries

  
  ##
  # a collection of all of the assets that are available with this video
  has_many :assets

  ##
  # a join association that ties one or more presenters with this video
  has_many :presentations

  ##
  # the presenters associated with this video
  has_many :presenters, :through => :presentations

  accepts_nested_attributes_for :presentations,
    :reject_if => lambda { |a| a[:presenter_id].blank? },
    :allow_destroy => true

  accepts_nested_attributes_for :assets,
    :reject_if => lambda { |a| a[:asset_type_id].blank? },
    :allow_destroy => true

  has_attached_file :image,
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
    :styles => {
      :thumb => '180x101',
      :preview => '640x360'
    },
  :default_url => '/system/:class/:attachment/missing-:style.png'

  scope :available, 
                :joins => 'INNER JOIN events ON videos.event_id = events.id',
                :conditions => ['videos.available = ? and events.private = ? ', 
                                true, false]

  cattr_reader :per_page

  ##
  # constant that lists the valid licenses that are supported by the
  # system
  LICENSES = [ "cc-by-sa-3.0"]

  ##
  # list of the valid ratings for the rating attribute
  RATINGS = [ "Not yet Rated", "Everyone", "Language", "Strong Language" ]

  @@per_page = 25

  ##
  # this class method returns a video collection where the videos
  # title matches 'like "%{search_term}%" and the video is available
  # or not based on the value of all (the second passed in option)
  #
  # takes one required and one optional parameter
  # 1 - search term
  # 2 - all, if not specified it searches all videos, if set to 0 it
  # only searches available videos
  def self.search(search, all = "1")
    if all == "1"
      if search
        search_results = self.find(:all,
                       :joins => 'INNER JOIN events ON events.id = videos.event_id',
                       :conditions => ['videos.title like ? and events.private = ?',
                                       "%#{search}%", false],
                       :order => 'post_date desc')
      else
        search_results = self.find(:all, :order => 'post_date desc')
      end
    else
      if search
        search_results = available.find(:all,
             :conditions => ['title like ?', "%#{search}%"],
             :order => 'post_date desc')
      else
        search_results = available.find(:all, :order => 'post_date desc')
      end
    end

    final_results = search_results.select{ |v| v.event.ready? }

    puts "SR: #{search_results.count} | FR: #{final_results.count}"

    return final_results
  end

  ##
  # this class method returns a random video that has a streaming
  # asset, is available, was recorded in the last 180 days, belongs to
  # an event that is set to ready, belongs to an event that is not
  # private
  def self.random
    if Rails.env == "production" || Rails.env == "development"
      order = 'rand()'
    else
      order = 'random()'
    end

    random_video = Video.first(:include => [:event],
                               :conditions => ["streaming_asset_id is not null and available = ? and recorded_at >= ? and events.ready = ? and events.private = ?", true, Date.today - 180, true, false],
                               :order => order)

    return random_video
  end

  ##
  # returns the link based on the license attribute, these are
  # hardcoded because it is a very limited set.
  def license_url
    case self.license
    when "cc-by-sa-3.0"
      "http://creativecommons.org/licenses/by-sa/3.0/"
    end
  end
  ##
  # returns the image file url for the license attribute, just like
  # license_url these are hardcoded, when we add support for a new
  # license we must deploy updated
  def license_image_file_url
    case self.license
    when "cc-by-sa-3.0"
      "http://i.creativecommons.org/l/by-sa/3.0/80x15.png"
    end
  end

  ##
  # override to_param to add the slug for the video to the URL
  def to_param
    "#{id}-#{slug}"
  end

  ##
  # method that determines the slug for the video
  def slug
    parts = Array.new
    parts << event.short_code
    parts << title.parameterize.to_s
    parts.join("-")
  end

  ##
  # this is a stupid hack to remove the cache buster from the
  # paperclip URL for the streaming_video 
  def streaming_video_url
    # TODO figure out how to remove the need for this stupid hack
    # paperclip adds the cache buster to the URL automatically, I need
    # it to go away, probably a really easy paperclip option, but not
    # finding it at the moment.
    unless streaming_video.nil?
      streaming_video.data.url.split("?")[0]
    else
      nil
    end
  end

  ##
  # a method that returns the presenters formatted for display, this
  #
  # TODO move to helper or presenter - get it out of the model
 
  def display_presenters
    out = ""
    self.presenters.each do |p|
      out += p.display_name + ", "
    end
    out = out[0,out.length-2]
  end

  ##
  # a method that is supposed to return the presenters with links to
  # their twitter account if it is there... but it fails.
  #
  # TODO move to helper or presenter
  def display_twitter_presenters
    out = ""
    out = self.presenters.each do |p|
      out += (p.twitter_name.nil? ? p.display_name : p.twitter_name) + ", "
    end
    out = out[0,out.length-2]
  end

  ##
  # this attribute makes it easier to access the aggregated view
  # information
  #
  # takes the number of days as a paramter, and returns all views
  # unless days matches seven or thirty - kind of suprising :(
  def views_for days = 0
    case days
    when 7
      views_last_7
    when 30
      views_last_30
    else
      views
    end
  end
end
