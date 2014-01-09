require "spec_helper"

describe HostnamesController do
  describe "routing" do

    it "routes to #index" do
      get("/hostnames").should route_to("hostnames#index")
    end

    it "routes to #new" do
      get("/hostnames/new").should route_to("hostnames#new")
    end

    it "routes to #show" do
      get("/hostnames/1").should route_to("hostnames#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hostnames/1/edit").should route_to("hostnames#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hostnames").should route_to("hostnames#create")
    end

    it "routes to #update" do
      put("/hostnames/1").should route_to("hostnames#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hostnames/1").should route_to("hostnames#destroy", :id => "1")
    end

  end
end
