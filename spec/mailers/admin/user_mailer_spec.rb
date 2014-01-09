require "spec_helper"

describe Admin::UserMailer do
  describe "new_signup" do
    let(:mail) { Admin::UserMailer.new_signup }

    it "renders the headers" do
      mail.subject.should eq("New signup")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
