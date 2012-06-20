module SpreeSearchRodamoto
  class Engine < Rails::Engine
    engine_name 'spree_search_rodamoto'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      if Spree::Config.instance
        Spree::Config.searcher_class = Spree::Search::Rodamoto
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
