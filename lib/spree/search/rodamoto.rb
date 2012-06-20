module Spree::Search
  class Rodamoto < Spree::Core::Search::Base
    def get_products_conditions_for(base_scope, query)
      fields = [:name, :description, :sku, :tire_fr_id, :tire_speed_code_id, 
                :tire_tttl_id, :tire_profile_id, :tire_ic_id, :tire_innertube_id, :tire_width_id]
      values = query.split

      where_str = fields.map{|field|
        case field
          when :sku
            Array.new(values.size, "variants.sku LIKE ?").join(' OR ')
          when :tire_fr_id
            Array.new(values.size, "variants.tire_fr_id = ?").join(' OR ')
          when :tire_speed_code_id
            Array.new(values.size, "variants.tire_speed_code_id = ?").join(' OR ')
          when :tire_tttl_id
            Array.new(values.size, "variants.tire_tttl_id = ?").join(' OR ')
          when :tire_profile_id
            Array.new(values.size, "variants.tire_profile_id = ?").join(' OR ')
          when :tire_ic_id
            Array.new(values.size, "variants.tire_ic_id = ?").join(' OR ')
          when :tire_innertube_id
            Array.new(values.size, "variants.tire_innertube_id = ?").join(' OR ')
          when :tire_width_id
            Array.new(values.size, "variants.tire_width_id = ?").join(' OR ')
          else
          Array.new(values.size, "products.#{field} LIKE ?").join(' OR ')
        end
      }.join(' OR ')
      base_scope.joins(:variants_including_master).where([where_str, values.map{|value| "%#{value}%"} * fields.size].flatten)
    end
  end
end
