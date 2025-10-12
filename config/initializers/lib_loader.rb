# frozen_string_literal: true

require "wink"

Pathname.glob("#{Rails.root}libwink*.rb").each do |lib|
  require "wink/#{lib.basename}"
end
