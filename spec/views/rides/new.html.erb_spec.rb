require 'spec_helper'

describe "rides/new.html.erb" do
  before(:each) do
    assign(:ride, stub_model(Ride,
      :name => "MyString",
      :favourite => false,
      :length => "9.99"
    ).as_new_record)
  end

  it "renders new ride form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rides_path, :method => "post" do
      assert_select "input#ride_name", :name => "ride[name]"
      assert_select "input#ride_favourite", :name => "ride[favourite]"
      assert_select "input#ride_length", :name => "ride[length]"
    end
  end
end
