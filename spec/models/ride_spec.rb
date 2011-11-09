require 'spec_helper'

describe Ride do
  subject { FactoryGirl.create :ride }

  it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :distance }

  specify "a favourite ride should always have a name" do
    subject.favourite = true
    subject.name = nil
    subject.should_not be_valid
  end
end
