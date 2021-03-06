require "spec_helper"

describe "nodejs::_apt" do
  describe "ubuntu platform" do
    let(:chef_run) do
      ChefSpec::Runner.new.converge(described_recipe)
    end

    it "includes the `apt` recipe" do
      expect(chef_run).to include_recipe "apt"
    end

    it "configures the apt repository" do
      expect(chef_run).to add_apt_repository "chris-lea-node.js"
    end

    describe "when `legacy` is `true`" do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set["nodejs"]["legacy"] = true
        end.converge(described_recipe)
      end

      it "includes the `apt` recipe" do
        expect(chef_run).to include_recipe "apt"
      end

      it "configures the apt repository" do
        expect(chef_run).to add_apt_repository "chris-lea-node.js-legacy"
      end
    end
  end

  describe "debian platform" do
    let(:chef_run) do
      env_options = { platform: "debian", version: "7.4" }
      ChefSpec::Runner.new(env_options).converge(described_recipe)
    end

    it "includes the `apt` recipe" do
      expect(chef_run).to include_recipe "apt"
    end

    it "configures the apt repository" do
      expect(chef_run).to add_apt_repository "wheezy-backports"
    end
  end
end
