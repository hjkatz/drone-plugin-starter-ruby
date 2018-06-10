# drone-plugin-starter-ruby

Starter project for creating a Drone Plugin with Ruby

### Metadata

Build and Repository metadata are prefixed with `DRONE_` and sent to the plugin at runtime. The full list of available parameters are already included in the `lib/drone_plugin/cli.rb` file as environment variable options. You should remove un-used parameters from the list so that one can easily see which parameters are used by which plugins.

Example parameters:

```ruby
use :DRONE_BUILD_NUMBER, "build number", class: ::Integer, default: -1
use :DRONE_BUILD_STATUS, "build status", class: ::String,  default: "success"
```

### Parameters

Plugin parameters are defined in the yaml file:

```yaml
drone_plugin:
  name: "Drone"
  template: "Hello, {{ config.name }}!"
```

They are prefixed with `PLUGIN_` and sent to the plugin at runtime:

```bash
PLUGIN_NAME="Drone"
PLUGIN_TEMPLATE="Hello, {{ config.name }}!"
```

These parameters can be retrieved using `ENV!` as seen below:

```ruby
ENV![:PLUGIN_NAME]
ENV![:PLUGIN_TEMPLATE]
```

> Note: These are passed to `DronePlugin::Plugin` as `opts` and duck-typed for `#[]`

### Secrets

Sensitive fields should not be specified in the yaml file. Instead they are passed to your plugin as environment variable. Secrets should use a prefix that corresponds to the plugin name. For example, the Slack plugin prefixes secrets with `SLACK_`:

### Logos

Please replace the logo.svg file with a meaningful svg logo for your plugin. If you are you building a Slack plugin, for example, please provide the Slack logo. This icon is displayed when your plugin is listed in the official plugin index.

### Docs

Please provide a DOCS.md file in the root of your repository that documents plugin usage. This documentation is displayed when your plugin is listed in the official plugin index. Use the README.md file to describe building and testing the plugin locally.

### Images

Images are distributed as Docker images in the public Docker registry. Please use a minimalist alpine image when possible to limit the image download size. We are also working on supporting multiple plugin architectures, with compatibility guidelines coming soon

### Testing

Please create plugins that are easily runnable from the command line. This makes it much easier to debug and test plugins locally without having to launch actual builds.
