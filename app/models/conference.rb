##
# this represents the conference itself as a whole, not an instance
# for a given time period
class Conference < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true  

  has_many :events

  def to_param
    "#{id}-#{slug}"
  end

  def slug
    name.strip.gsub(" ","-").downcase
  end
end
