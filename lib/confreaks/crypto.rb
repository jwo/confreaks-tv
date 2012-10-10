require 'digest/sha1'

module Confreaks  #:nodoc:

  module Crypto
    def digest thing, *extras
      Digest::SHA1.hexdigest(([thing] + extras).join(" "))
    end

    def salt *extras
      digest ActiveSupport::SecureRandom.hex(64), Time.now, *extras
    end

    module_function :digest, :salt
  end
end
