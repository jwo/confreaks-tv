class List < ActiveRecord::Base
  attr_accessible :name, :description, :public

  belongs_to :user

  has_many :entries, :class_name => "ListEntry"
  has_many :videos, :through => :entries
  
end
