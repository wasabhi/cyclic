require 'spec_helper'

describe Ride do
  subject { FactoryGirl.create :ride }

  it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :length }
end
