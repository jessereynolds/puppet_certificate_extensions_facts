require 'facter'
require 'puppet'

describe 'certificate extensions facts' do
  settings = {
    ssldir:   '/foo/bar',
    certname: 'baz',
  }

  context 'something' do
    it 'returns an instance id' do
      settings = instance_double('settings')
      expected_value = 'i-00000002'
      # expect(settings).to receive(:foo).with("suspended as")
    end
  end
end
