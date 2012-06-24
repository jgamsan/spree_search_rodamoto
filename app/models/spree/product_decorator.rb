Spree::Product.class_eval do
  scope :by_width, lambda { |width| joins(:variants).where("spree_variants.tire_width_id = ?", width)}
  scope :by_profile, lambda { |profile| joins(:variants).where("spree_variants.tire_profile_id = ?", profile)}
  scope :by_innertube, lambda { |innertube| joins(:variants).where("spree_variants.tire_innertube_id = ?", innertube)}
  scope :by_ic, lambda { |ic| joins(:variants).where("spree_variants.tire_ic_id = ?", ic) }
  scope :by_speed, lambda { |speed| joins(:variants).where("spree_variants.tire_speed_code_id = ?", speed)}
  scope :by_fr, lambda { |fr| joins(:variants).where("spree_variants.tire_fr_id = ?", fr)}
  scope :by_tttl, lambda { |tttl| joins(:variants).where("spree_variants.tire_tttl_id = ?", tttl)}
end
