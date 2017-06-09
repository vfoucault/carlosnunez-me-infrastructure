require 'yaml'
require 'rspec'
require 'open3'

if not ENV['TARGET_ENVIRONMENT']
  raise 'TARGET_ENVIRONMENT not found in your environment; please define it.'
end

RSpec.configure do |config|
  config.before(:all) {
    _, $terraform_plan_stderr, _ = 
      Open3.capture3("terraform plan -state=nil_state_for_testing -out=temp.tfstate")
    terraform_plan_json_str = `[ -f temp.tfstate ] && tfjson temp.tfstate`
    $terraform_plan = JSON.parse(terraform_plan_json_str)
  }
end
