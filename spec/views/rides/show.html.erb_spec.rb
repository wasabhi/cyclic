require 'spec_helper'

describe "rides/show.html.erb" do
  before(:each) do
    @ride = assign(:ride, stub_model(Ride,
      :name => "Name",
      :favourite => false,
      :distance => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
  end
end
