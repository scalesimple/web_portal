require "spec_helper"

describe DnsMailer do
  describe "hostname_active" do
    let(:mail) { DnsMailer.hostname_active }

    it "renders the headers" do
      mail.subject.should eq("Hostname active")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
