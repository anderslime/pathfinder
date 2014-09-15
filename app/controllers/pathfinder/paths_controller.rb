module Pathfinder
  class PathsController < ApplicationController

    def index
      route_set = Pathfinder::Config.journey_route_resolver.call(self)
      grouped_paths = Pathfinder::PathService.grouped_paths(route_set)
      render json: JSON.pretty_generate(grouped_paths)
    end

  end
end
