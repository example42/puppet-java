require 'spec_helper'

describe 'java' do
    let(:node) { 'java.example42.com' }
    let(:facts) {{
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '12.10'
    }}

    describe 'generic test' do
        it { should compile }
        it { should contain_class('java') }
    end
end
