require 'spec_helper'

describe 'elasticsearch', :type => :class do
  context 'defaults' do
    let(:params) { {  } }
    it 'default' do
      should include_class('elasticsearch::install')
      should include_class('elasticsearch::config')
      should include_class('elasticsearch::service')
    end
  end
  context 'parameterized' do
    let(:params) { {
      :unicast => [ 'host0.example.com', 'host1.example.com' ],
      :java_package => 'java-1.7.0-oracle',
      :es_dir_work  => '/tmp',
    } }
    it 'parameterized' do
      should contain_class('elasticsearch::install')
      should contain_class('elasticsearch::config')
      should contain_class('elasticsearch::service')
    end
  end
  context 'malformed unicast' do
    let(:params) { {
      :unicast      => 'host0.example.com',
      :java_package => 'java-1.7.0-oracle',
      :es_dir_work  => '/tmp',
    } }
    it do
      expect {
        should include_class('elasticsearch::install')
        should include_class('elasticsearch::config')
        should include_class('elasticsearch::service')
      }.to raise_error(Puppet::Error, /is not an Array/)
    end
  end
  context 'bad parameters' do
    let(:params) { {
      :foo => 'bar'
    } }
    it do
      expect {
        should include_class('elasticsearch::install')
        should include_class('elasticsearch::config')
        should include_class('elasticsearch::service')
      }.to raise_error(Puppet::Error, /Invalid parameter foo/)
    end
  end
end

# vim: set ts=2 sw=2 et ft=ruby:
