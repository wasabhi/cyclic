require 'spec_helper'

describe User do
  subject { FactoryGirl.create :user }

  it { should belong_to :account }
  it { should have_many :rides }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :account }

  specify "that the to_s method responds with the name or the email of the user" do
    subject.to_s.should == subject.name
    subject.name = nil
    subject.to_s.should == subject.email
  end
end
