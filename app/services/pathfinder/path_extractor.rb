module Pathfinder
  class PathExtractor
    def initialize(routes)
      @routes = routes
    end

    def extract
      @routes.map do |route|
        route.path.spec.to_s
      end
    end

  end
end
