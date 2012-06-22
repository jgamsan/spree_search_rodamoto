module Spree::Search
  class Rodamoto < Spree::Core::Search::Base
    def get_base_scope
      base_scope = @cached_product_group ? @cached_product_group.products.active : Spree::Product.active
      base_scope = base_scope.by_width(tire_width_id) if tire_width_id
      base_scope = base_scope.by_profile(tire_profile_id) if tire_profile_id
      base_scope = base_scope.by_innertube(tire_innertube_id) if tire_innertube_id
      base_scope = base_scope.by_ic(tire_ic_id) if tire_ic_id
      base_scope = base_scope.by_speed(tire_speed_code_id) if tire_speed_code_id
      base_scope = base_scope.by_fr(tire_fr_id) if tire_fr_id
      base_scope = base_scope.by_tttl(tire_tttl_id) if tire_tttl_id
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?
      base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
      base_scope = add_search_scopes(base_scope)
      base_scope
    end
    
    def prepare(params)
      @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
      @properties[:keywords] = params[:keywords]
      @properties[:search] = params[:search]

      per_page = params[:per_page].to_i
      @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
      @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
      #@properties[:tire_width_id] = params[:tire_width_id].empty? ? nil : params[:tire_width_id]
      #@properties[:tire_profile_id] = params[:tire_profile_id].empty? ? nil : params[:tire_profile_id]
      #@properties[:tire_innertube_id] = params[:tire_innertube_id].empty? ? nil : params[:tire_innertube_id]
      #@properties[:tire_ic_id] = params[:tire_ic_id].empty? ? nil : params[:tire_ic_id]
      #@properties[:tire_speed_code_id] = params[:tire_speed_code_id].empty? ? nil : params[:tire_speed_code_id]
      #@properties[:tire_fr_id] = params[:tire_fr_id].empty? ? nil : params[:tire_fr_id]
      #@properties[:tire_tttl_id] = params[:tire_tttl_id].empty? ? nil : params[:tire_tttl_id]
    end    
  end
end
