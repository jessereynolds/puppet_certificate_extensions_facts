require 'facter'
require 'puppet'

describe 'certificate extensions facts' do
  settings = {
    :ssldir => '/foo/bar',
    :certname => 'baz',
  }

  context 'something' do

    it "returns an instance id" do
      settings = double("settings")

      expected_value = 'i-00000001'


    end

  end
end

