#
# behaviour testing for individual interfaces
# 
require 'spec_helper'

describe 'network::interfaces' do
  let(:node) { 'testhost.example.org' }
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
  
  context 'create interface definition' do
    let(:params) { {
      :interfaces => { 
        'eth0' => {'method' => 'dhcp'}, 
        'eth1' => {
          'method' => 'static',
          'address' => '192.168.0.1',
          'netmask' => '255.255.0.0'
        }
      }, 
      :auto       => [ 'eth0', 'eth1'],
    } }

    it do
      should contain_file('/etc/network/interfaces').that_notifies('Service[networking]')

      should contain_service('networking').with(
        'ensure' => 'running'
      )
      
    end
  end
end