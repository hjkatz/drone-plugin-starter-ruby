require "spec_helper"

RSpec.describe DronePlugin::Plugin do
  let(:default_options) { Hash.new.update({
    # plugin settings
    PLUGIN_NAME: "Drone",
    PLUGIN_TEMPLATE: "Testing: {{ config.name }}",

    # drone settings
    DRONE_REPO_OWNER: "repo_owner",
    DRONE_REPO_NAME: "repo_name",
    DRONE_COMMIT_BRANCH: "master",
  })}

  describe "#initialize" do
    subject(:plugin) { DronePlugin::Plugin.new(opts) }

    context "when given empty options" do
      let(:opts) { Hash.new }

      it { is_expected.to have_attributes(
        config: have_attributes(
          name: be_nil,
          template: be_nil,
        )
      ) }
    end

    context "when given default options" do
      let(:opts) { default_options }

      it { is_expected.to have_attributes(
        config: have_attributes(
          name: default_options[:PLUGIN_NAME],
          template: default_options[:PLUGIN_TEMPLATE],
        )
      ) }
    end
  end

  describe "#run" do
    subject { -> { plugin.run } }

    let(:plugin) { DronePlugin::Plugin.new(default_options) }

    it { is_expected.to output(/Testing:/).to_stdout }
    it { is_expected.to output(/Drone/).to_stdout }
  end
end
