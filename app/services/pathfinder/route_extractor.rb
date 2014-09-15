module Pathfinder
  class RouteExtractor

    attr_reader :journey_routes
    def initialize(journey_routes)
      @journey_routes = journey_routes
    end

    def extract
      journey_routes.to_a.map do |route|
        if route.app.respond_to?(:routes)
          route.app.routes.routes.to_a
        else
          route
        end
      end.flatten
    end

  end
end
