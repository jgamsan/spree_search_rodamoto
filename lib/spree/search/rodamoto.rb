module Spree::Search
  class Rodamoto < Spree::Core::Search::Base
    def get_base_scope
      base_scope = @cached_product_group ? @cached_product_group.products.active : Spree::Product.active
      base_scope = base_scope.by_width(tire_width_id)
      base_scope = base_scope.by_profile(tire_profile_id)
      base_scope = base_scope.by_innertube(tire_innertube_id)
      base_scope = base_scope.by_ic(tire_ic_id)
      base_scope = base_scope.by_speed(tire_speed_code_id)
      base_scope = base_scope.by_fr(tire_fr_id)
      base_scope = base_scope.by_tttl(tire_tttl_id)
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?
      base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
      base_scope = add_search_scopes(base_scope)
      base_scope
    end
    
    def prepare(params)
      super
      @properties[:tire_width_id] = params[:tire_width_id]
      @properties[:tire_profile_id] = params[:tire_profile_id]
      @properties[:tire_innertube_id] = params[:tire_innertube_id]
      @properties[:tire_ic_id] = params[:tire_ic_id]
      @properties[:tire_speed_code_id] = params[:tire_speed_code_id]
      @properties[:tire_fr_id] = params[:tire_fr_id]
      @properties[:tire_tttl_id] = params[:tire_tttl_id]
    end    
  end
end
