require 'test_helper'

class PathfinderTest < ActionDispatch::IntegrationTest
  def setup
    get '/pathfinder'
    parsed_response_body = JSON.parse(body, symbolize_names: true)
    @static_routes   = parsed_response_body[:static_paths]
    @wildcard_routes = parsed_response_body[:wildcard_paths]
  end

  test "works" do
    assert_equal 200, status
  end

  test "simple static routes" do
    assert_includes @static_routes, "/news"
  end

  test "namespaced routes" do
    assert_includes @static_routes, "/hello/world"
  end

  test "resource routes" do
    assert_includes @static_routes, "/locations"
  end

  test "wildcard routes" do
    assert_includes @wildcard_routes, "/wildcard/*/route"
  end
end
