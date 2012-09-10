class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid

  belongs_to :user

  validates :provider, :presence => true
  validates :uid, :presence => true, :uniqueness => {:scope => :provider}
  validates :user_id, :presence => true
  
  def provider_name
    if provider == "openid"
      "Open ID"
    else
      provider.titleize
    end
  end
end
