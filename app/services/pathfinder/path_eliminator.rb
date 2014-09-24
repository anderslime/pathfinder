module Pathfinder
  class PathEliminator

    attr_reader :paths

    class << self
      def simplify(paths)
        new(paths).simplify!
      end
    end

    def initialize(paths)
      @paths = paths.dup
    end

    def simplify!
      remove_format
      substitute_placeholders
      substitute_greedy_segment_matchers
      apply_greedy_paths!
      eliminate_redundant_paths
      remove_root_path
      paths.uniq
    end

    private

    def remove_format
      paths.map! do |path|
        path.chomp("(.:format)")
      end
    end

    def remove_root_path
      paths.reject! do |path|
        path == "/"
      end
    end

    def substitute_placeholders
      paths.map! do |path|
        path.gsub(/:[^\/]+/, '*') # Removes /the/route/:id/parts
          .gsub(/\(\/.*\)/, '/*') # Remove optional things in parenthesis
      end
    end

    def substitute_greedy_segment_matchers
      paths.map! do |path|
        path.gsub(/\*[^\/]+/, '*') # Change /things/like/a/*splat into things/like/a/*
      end
    end

    def apply_greedy_paths!
      Pathfinder::Config.greedy_paths.each do |greedy_path|
        paths.delete_if do |path|
          path.start_with? greedy_path
        end
        paths.push greedy_path
        paths.push greedy_path + "*"
      end
      paths.sort!
    end

    def eliminate_redundant_paths
      all_paths = paths.dup
      all_paths.each do |root_path|
        if root_path.ends_with?("*")
          paths.delete_if do |redundant_path|
            redundant_path.start_with?(root_path.chomp("*")) && root_path != redundant_path
          end
        end
      end
    end

  end
end
