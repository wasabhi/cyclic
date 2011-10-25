require 'spec_helper'

describe Account do
  subject { FactoryGirl.create :account }

  it { should have_many :users }
  it { should validate_presence_of :name }

  it "should have a unique name" do
    account = FactoryGirl.create :account
    subject.name = account.name
    subject.should_not be_valid
  end
end
