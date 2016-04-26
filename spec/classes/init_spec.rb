require 'spec_helper'

 describe 'java' do
   let(:facts) do
     { :osfamily                  => 'Debian',
       :operatingsystemmajrelease => '6',
     }
   end

   context 'with defaults for all parameters' do
     it { should contain_class('java') }

     it { should compile.with_all_deps }
   end

 describe 'variable type and content validations' do
   let(:validation_params) do
      {
        #:param => 'value',
      }
   end

   validations = {
     'absolute_path' => {
       :name    => ['java_home_base'],
       :valid   => ['/usr/lib/jvm'],
       :invalid => ['invalid',3,2.42,['array'],a={'ha'=>'sh'}],
       :message => 'is not an absolute path',
     },
     'version'        => {
       :name    => ['version'] ,
       :valid   => ['6'],
       :invalid => [['array'],a={'ha'=>'sh'}, true],
       :message => 'is not a string',
    },
  }

  validations.sort.each do |type, var|
    var[:name].each do |var_name|
      var[:valid].each do |valid|
        context "with #{var_name} (#{type}) set to valid #{valid} (as #{valid.class})" do
          let(:params) { validation_params.merge({ :"#{var_name}" => valid, }) }
          it { should compile }
         end
       end

       var[:invalid].each do |invalid|
         context "with #{var_name} (#{type}) set to invalid #{invalid} (as #{invalid.class})" do
          let(:params) { validation_params.merge({ :"#{var_name}" => invalid, }) }
            it 'should fail' do
              expect do
                should contain_class(subject)
              end.to raise_error(Puppet::Error, /#{var[:message]}/)
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe
end
