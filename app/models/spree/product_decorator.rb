Spree::Product.class_eval do
  scope :by_width, lambda { |width| where(:tire_width_id => width) }
  scope :by_profile, lambda { |profile| where(:tire_profile_id => profile) }
  scope :by_innertube, lambda { |innertube| where(:tire_innertube_id => innertube) }
  scope :by_ic, lambda { |ic| where(:tire_ic_id => ic) }
  scope :by_speed, lambda { |speed| where(:tire_speed_code_id => speed) }
  scope :by_fr, lambda { |fr| where(:tire_fr_id => fr) }
  scope :by_tttl, lambda { |tttl| where(:tire_tttl_id => tttl) }
end
