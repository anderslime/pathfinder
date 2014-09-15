module Pathfinder
  class Config
    class << self
      attr_accessor :greedy_paths
      attr_accessor :journey_route_resolver
    end

    if self.greedy_paths.nil?
      self.greedy_paths = []
    end
    self.journey_route_resolver = ->(controller) { Rails.application.routes.routes }

  end
end
