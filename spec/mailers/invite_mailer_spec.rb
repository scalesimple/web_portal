require "spec_helper"

describe InviteMailer do
  describe "grant_account_permission" do
    let(:mail) { InviteMailer.grant_account_permission }

    it "renders the headers" do
      mail.subject.should eq("Grant account permission")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
