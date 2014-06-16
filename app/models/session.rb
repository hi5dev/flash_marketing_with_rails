class Session < ActiveRecord::SessionStore::Session
  scope :active, lambda { all.select(&:active?) }
    
  def active?
    data['last_seen_at'] && data['last_seen_at'] > 1.minute.ago
  end

  def flash(id, msg)
    data['flash'] ||= {'flashes' => {}, 'discard' => []}
    data['flash']['flashes'][id.to_sym] = msg
  end

  def display_promotion(id, track=true)
    viewed_promotions << id if track
    promotion = Promotion.find(id)
    flash :promotion, promotion.call_to_action
  end

  def viewed_promotions
    data['viewed_promotions'] ||= []
  end
end
