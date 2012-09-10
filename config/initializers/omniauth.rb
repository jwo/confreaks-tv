require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '381019088636710', '9894134aba4e68d0abc5b91232d014b1'

  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp'),
    :name => 'openid'

  provider :twitter, 'ngFg1EFs1htBwojgCYqcgg',
                     'cV0mzL2swcNhEFAhkSSuhTdqEJzYrC4tYJneIf0LTE'

  provider :github, '5422b820071b310d6793',
                    '2bb2e5ee0fb62930f7c37050327011357b226aa7'

end
  
  
