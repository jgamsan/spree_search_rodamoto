module Spree::Search
  class Rodamoto < Spree::Core::Search::Base
    def get_base_scope
      base_scope = @cached_product_group ? @cached_product_group.products.active : Spree::Product.active
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?
      base_scope = get_products_conditions_for_width(base_scope, tire_width_id) unless tire_width_id.blank?
      base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
      base_scope = add_search_scopes(base_scope)
      base_scope
    end
    
    def get_products_conditions_for_width(base_scope, width)
      Array.new(width, "variants.tire_width_id = ?").join(' AND ') 
    end
    
    def get_products_conditions_for_rodamoto(base_scope, parametros)
      fields = [:tire_width_id, :tire_profile_id, :tire_innertube_id,
                :tire_speed_code_id, :tire_ic_id, :tire_fr_id, :tire_tttl_id]
      where_str = fields.map{|field|
        if field == :tire_width_id && !parametros[:tire_width_id].empty?
          Array.new(parametros[:tire_width_id], "variants.tire_width_id = ?").join(' AND ')
        end
        if field == :tire_profile_id && !parametros[:tire_profile_id].empty?
          Array.new(parametros[:tire_profile_id], "variants.tire_profile_id = ?").join(' AND ')
        end
        if field == :tire_innertube_id && !parametros[:tire_innertube_id].empty?
          Array.new(parametros[:tire_innertube_id], "variants.tire_innertube_id = ?").join(' AND ')
        end
        if field == :tire_speed_code_id && !parametros[:tire_speed_code_id].empty?
          Array.new(parametros[:tire_speed_code_id], "variants.tire_speed_code_id = ?").join(' AND ')
        end
        if field == :tire_ic_id && !parametros[:tire_ic_id].empty?
          Array.new(parametros[:tire_ic_id], "variants.tire_ic_id = ?").join(' AND ')
        end
        if field == :tire_fr_id && !parametros[:tire_fr_id].empty?
          Array.new(parametros[:tire_fr_id], "variants.tire_fr_id = ?").join(' AND ')
        end
        if field == :tire_tttl_id && !parametros[:tire_tttl_id].empty?
          Array.new(parametros[:tire_tttl_id], "variants.tire_tttl_id = ?").join(' AND ')
        end
      }.join(' OR ')
      
      base_scope.joins(:variants_including_master).where([where_str, values.map{|value| "%#{value}%"} * fields.size].flatten)
    end
    
    
    def prepare(params)
      @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
      @properties[:keywords] = params[:keywords]
      @properties[:search] = params[:search]

      per_page = params[:per_page].to_i
      @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
      @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
      unless params[:tire_width_id].nil?
        @properties[:tire_width_id] = params[:tire_width_id].empty? ? nil : params[:tire_width_id]
      end
      unless params[:tire_profile_id].nil?
        @properties[:tire_profile_id] = params[:tire_profile_id].empty? ? nil : params[:tire_profile_id]
      end
      unless params[:tire_innertube_id].nil?
        @properties[:tire_innertube_id] = params[:tire_innertube_id].empty? ? nil : params[:tire_innertube_id]
      end
      unless params[:tire_speed_code_id].nil?
        @properties[:tire_speed_code_id] = params[:tire_speed_code_id].empty? ? nil : params[:tire_speed_code_id]
      end
      unless params[:tire_ic_id].nil?
        @properties[:tire_ic_id] = params[:tire_ic_id].empty? ? nil : params[:tire_ic_id]
      end
      unless params[:tire_fr_id].nil?
        @properties[:tire_fr_id] = params[:tire_fr_id].empty? ? nil : params[:tire_fr_id]
      end
      unless params[:tire_tttl_id].nil?
        @properties[:tire_tttl_id] = params[:tire_tttl_id].empty? ? nil : params[:tire_tttl_id]
      end
    end    
  end
end
