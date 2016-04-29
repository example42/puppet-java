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
    # set needed custom facts and variables
    let(:facts) do
      {
        :operatingsystem        => 'Ubuntu',
        :operatingsystemrelease => '14.04',
      }
    end
    let(:mandatory_params) do
      {
        #:param => 'value',
      }
    end

    validations = {
      'absolute_path' => {
        :name    => %w(java_home_base),
        :valid   => ['/absolute/filepath', '/absolute/directory/', %w(/array /with_paths)],
        :invalid => ['../invalid', 3, 2.42, %w(array), { 'ha' => 'sh' }, true, false, nil],
        :message => 'is not an absolute path',
      },
      'string' => {
        :name    => %w(package package_jdk version),
        :valid   => ['string'],
        :invalid => [%w(array), { 'ha' => 'sh' }, 3, 2.42, true, false],
        :params  => { :jdk => true },
        :message => 'is not a string',
      },
      'bool_stringified' => {
        :name    => %w(jdk headless absent debug),
        #:valid   => [true, false, 'true', 'false'],
        :valid   => [true, false],
        :invalid => ['invalid', %w(array), { 'ha' => 'sh' }, 3, 2.42, nil],
        :message => '(Unknown type of boolean|str2bool\(\): Requires either string to work with)',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => valid, }].reduce(:merge) }
            it { should compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => invalid, }].reduce(:merge) }
            it 'should fail' do
              expect { should contain_class(subject) }.to raise_error(Puppet::Error, /#{var[:message]}/)
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
