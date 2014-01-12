require "spec_helper"

describe PurgesController do
  describe "routing" do

    it "routes to #index" do
      get("/purges").should route_to("purges#index")
    end

    it "routes to #new" do
      get("/purges/new").should route_to("purges#new")
    end

    it "routes to #show" do
      get("/purges/1").should route_to("purges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/purges/1/edit").should route_to("purges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/purges").should route_to("purges#create")
    end

    it "routes to #update" do
      put("/purges/1").should route_to("purges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/purges/1").should route_to("purges#destroy", :id => "1")
    end

  end
end
