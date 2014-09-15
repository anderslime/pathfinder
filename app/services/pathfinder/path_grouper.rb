module Pathfinder
  class PathGrouper

    def initialize(paths)
      @paths = paths
    end

    def static_paths
      @paths.find_all do |path|
        path.exclude? '*'
      end
    end

    def wildcard_paths
      @paths.find_all do |path|
        path.include? '*'
      end
    end

  end
end
