require 'spec_helper'

describe "rides/edit.html.erb" do
  before(:each) do
    @ride = assign(:ride, stub_model(Ride,
      :name => "MyString",
      :favourite => false,
      :distance => "9.99"
    ))
  end

  it "renders the edit ride form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rides_path(@ride), :method => "post" do
      assert_select "input#ride_name", :name => "ride[name]"
      assert_select "input#ride_favourite", :name => "ride[favourite]"
      assert_select "input#ride_distance", :name => "ride[distance]"
    end
  end
end
