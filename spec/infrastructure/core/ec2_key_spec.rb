require 'spec_helper'

describe "EC2Key" do
  before(:all) do
    @ec2_key_details = $terraform_plan['ec2-instance-key']['aws_key_pair.keypair']
  end

  it "should be present" do
    expect(@ec2_key_details).not_to be_nil
  end

  it "should get the key name specified" do
    expected_key_name = $terraform_tfvars['ec2_key_name']
    actual_key_name = @ec2_key_details['key_name']
    expect(expected_key_name).to eq actual_key_name
  end

  it "should retrieve the publc key specified" do
    expected_pubkey = $terraform_tfvars['ec2_public_key']
    actual_pubkey = @ec2_key_details['public_key'].gsub /ssh-rsa/, "ssh-rsa "
    expect(expected_pubkey).to eq actual_pubkey
  end
end
