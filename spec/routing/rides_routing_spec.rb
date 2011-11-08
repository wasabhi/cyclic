require "spec_helper"

describe RidesController do
  describe "routing" do

    it "routes to #index" do
      get("/rides").should route_to("rides#index")
    end

    it "routes to #new" do
      get("/rides/new").should route_to("rides#new")
    end

    it "routes to #show" do
      get("/rides/1").should route_to("rides#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rides/1/edit").should route_to("rides#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rides").should route_to("rides#create")
    end

    it "routes to #update" do
      put("/rides/1").should route_to("rides#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rides/1").should route_to("rides#destroy", :id => "1")
    end

  end
end
