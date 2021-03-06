require 'spec_helper'

require 'puppet/server/master'
require 'puppet/server/jvm_profiler'

describe Puppet::Server::Master do
  context "run mode" do
    it "is set to 'master'" do
      master = Puppet::Server::Master.new({}, {})
      master.run_mode.should == 'master'
    end
  end

  context "puppet version" do
    it "returns the correct puppet version number" do
      master = Puppet::Server::Master.new({}, {})
      master.puppetVersion.should == '3.7.3'
    end
  end

  class MasterTestProfiler
    def start(description, metric_id)
      metric_id
    end

    def finish(context, description, metric_id)
    end

    def shutdown()
    end
  end

  context "profiler" do
    it "does not register a profiler if profiler is set to nil" do
      master = Puppet::Server::Master.new({}, {})
      Puppet::Util::Profiler.current.length.should == 0
    end

    it "registers a profiler if the profiler is not nil" do
      master = Puppet::Server::Master.new({}, {"profiler" => MasterTestProfiler.new})
      Puppet::Util::Profiler.current.length.should == 1
    end
  end
end
