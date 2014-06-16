require 'clockwork'

require_relative '../config/boot'
require_relative '../config/environment'

module Clockwork
  every(1.minute, 'random.promotions') {
    Session.all.each {|session|
      promotion = Promotion.all.sample
      next if session.viewed_promotions.include?(promotion.id)
      session.display_promotion(promotion.id)
      session.save!
    }
  }
end
