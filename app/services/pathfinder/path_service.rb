module Pathfinder
  class PathService
    class << self
      def grouped_paths(route_set)
        all_routes = Pathfinder::RouteExtractor.new(route_set).extract
        all_paths = Pathfinder::PathExtractor.new(all_routes).extract
        remaining_paths = Pathfinder::PathEliminator.simplify(all_paths)
        grouper = Pathfinder::PathGrouper.new(remaining_paths)
        {static_paths: grouper.static_paths, wildcard_paths: grouper.wildcard_paths}
      end
    end
  end
end
