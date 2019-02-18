require 'spec_helper'
describe 'gogs' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults" do
      let(:facts) do
        facts
      end
      let(:pre_condition) { "define puppetstats($enabled) {}" }
      it {should contain_class('gogs')}
    end
  end
end
