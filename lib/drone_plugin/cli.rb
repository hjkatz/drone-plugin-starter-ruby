require "time"
require "env_bang"

module DronePlugin
  # Drone Plugin CLI runner
  class CLI
    class << self
      # Default name for the template
      DEFAULT_NAME = "World"

      # Default template to print
      DEFAULT_TEMPLATE = "Hello, {{ config.name }}!"

      # Parse the drone environment variables for the plugin
      def parse_env
        ENV!.config do
          # Drone provides epochs for time arguments
          add_class :epoch do |val, _|
            Time.at(val.to_i)
          end

          # plugin config
          use :PLUGIN_TEMPLATE, "Missing key template: template to print",        class: ::String, default: DEFAULT_TEMPLATE
          use :PLUGIN_NAME,     "Missing key name: name for use in the template", class: ::String, default: DEFAULT_NAME

          # drone plugin default config
          use :DRONE_REPO_OWNER,     "repository owner",        class: ::String,  default: ""
          use :DRONE_REPO_NAME,      "repository name",         class: ::String,  default: ""
          use :DRONE_COMMIT_SHA,     "git commit sha",          class: ::String,  default: ""
          use :DRONE_COMMIT_REF,     "git commit ref",          class: ::String,  default: "refs/heads/master"
          use :DRONE_COMMIT_BRANCH,  "git commit branch",       class: ::String,  default: "master"
          use :DRONE_COMMIT_AUTHOR,  "git commit author name",  class: ::String,  default: ""
          use :DRONE_PULL_REQUEST,   "git pull request",        class: ::String,  default: ""
          use :DRONE_COMMIT_MESSAGE, "git commit message",      class: ::String,  default: ""
          use :DRONE_BUILD_EVENT,    "build event",             class: ::String,  default: "push"
          use :DRONE_BUILD_NUMBER,   "build number",            class: ::Integer, default: -1
          use :DRONE_BUILD_STATUS,   "build status",            class: ::String,  default: "success"
          use :DRONE_BUILD_LINK,     "build line",              class: ::String,  default: ""
          use :DRONE_BUILD_STARTED,  "build started",           class: :epoch,    default: Time.now
          use :DRONE_BUILD_CREATED,  "build created",           class: :epoch,    default: Time.now
          use :DRONE_JOB_STARTED,    "job started",             class: :epoch,    default: Time.now
          use :DRONE_TAG,            "build tag",               class: ::String,  default: ""
          use :DRONE_DEPLOY_TO,      "environment deployed to", class: ::String,  default: ""
        end
      end

      # Execute the plugin
      def exec
        DronePlugin::CLI.parse_env
        DronePlugin::Plugin.new(ENV!).run
      end
    end
  end
end
