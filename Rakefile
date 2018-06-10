require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new

task default: %w{spec build docker:build}

namespace "docker" do
  DOCKER_IMAGE_TAG = "drone-plugin-starter-ruby"

  desc "Build docker container"
  task :build do
    sh "docker build --rm -t #{DOCKER_IMAGE_TAG} ."
  end

  desc "Push the docker container to the registry"
  task :push do
    sh "docker push #{DOCKER_IMAGE_TAG}"
  end
end
