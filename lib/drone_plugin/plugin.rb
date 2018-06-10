require "ostruct"
require "liquid"
require "json"

module DronePlugin
  # Drone Plugin logic controller
  class Plugin
    attr_reader :config, :repo, :build, :job

    def initialize(opts)
      @config = OpenStruct.new({
        name:     opts[:PLUGIN_NAME],
        template: opts[:PLUGIN_TEMPLATE],
      })

      @repo = OpenStruct.new({
        owner: opts[:DRONE_REPO_OWNER],
        name:  opts[:DRONE_REPO_NAME],
      })

      @build = OpenStruct.new({
        tag:       opts[:DRONE_TAG],
        number:    opts[:DRONE_BUILD_NUMBER],
        event:     opts[:DRONE_BUILD_EVENT],
        status:    opts[:DRONE_BUILD_STATUS],
        commit:    opts[:DRONE_COMMIT_SHA],
        ref:       opts[:DRONE_COMMIT_REF],
        branch:    opts[:DRONE_COMMIT_BRANCH],
        author:    opts[:DRONE_COMMIT_AUTHOR],
        pull:      opts[:DRONE_PULL_REQUEST],
        message:   opts[:DRONE_COMMIT_MESSAGE],
        deploy_to: opts[:DRONE_DEPLOY_TO],
        link:      opts[:DRONE_BUILD_LINK],
        started:   opts[:DRONE_BUILD_STARTED],
        created:   opts[:DRONE_BUILD_CREATED],
      })

      @job = OpenStruct.new({
        started: opts[:DRONE_JOB_STARTED],
      })
    end

    # Run the plugin
    def run
      template = Liquid::Template.parse(@config.template)

      # liquid only accepts string keys
      result = template.render(
        "config" => JSON.parse(@config.to_h.to_json),
      )

      $stdout.puts result
    end
  end
end
