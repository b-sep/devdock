# frozen_string_literal: true

require 'test_helper'

class TestDevdock < Minitest::Test
  def setup
    @name = 'example'
  end

  def teardown
    FileUtils.rm_rf([@name])
  end

  def test_that_it_has_a_version_number
    refute_nil ::Devdock::VERSION
  end

  def test_create_project
    Devdock.stub(:docker_installed?, true) do
      assert_output(
        "      create  example\n      create  example/Dockerfile.dev\n      create  example/docker-compose.yml\n" \
        "      create  example/Makefile\n"
      ) do
        Devdock.create(@name)
      end

      assert(Dir.exist?(@name))
      assert_includes(Dir.entries(@name), 'Dockerfile.dev')
      assert_includes(Dir.entries(@name), 'docker-compose.yml')
      assert_includes(Dir.entries(@name), 'Makefile')
    end
  end

  def test_display_message_if_docker_isnt_present
    Devdock.stub(:docker_installed?, false) do
      assert_output(
        "You need to install docker to use devdock.\n" \
        "To information about how install it, visit: https://docs.docker.com/engine/install/\n"
      ) do
        Devdock.create(@name)
      end

      refute(Dir.exist?(@name))
    end
  end
end
