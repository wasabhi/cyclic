require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  before do
    @user = FactoryGirl.create :user
  end

  subject { Ability.new(@user) }

  it "should be an ability object" do
    subject.should be_instance_of Ability
  end

  it "should be able to manage self" do
    subject.can?(:manage, @user).should be_true
  end

  specify "a user should not be able to manage another user" do
    subject.can?(:manage, FactoryGirl.create(:user)).should be_false
  end
end
