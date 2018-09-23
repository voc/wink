require 'wink'

Pathname.glob(Rails.root + 'lib' + 'wink' + '*.rb').each do |lib|
  require "wink/#{lib.basename}"
end

