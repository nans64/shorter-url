require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do

  context "model testing" do

    describe "sanitize" do
      it "should return a sanatize URL" do
        url_client = "http://google.fr/"
        url = ShortenedUrl.sanitize(url_client)
        expect(url).to eq("http://google.fr/")
      end
    end


    describe "add_days" do # Create an entry first then pass the test
      it "should return a add days to the expiration date" do
        url_client = "http://google.fr/"
        url = ShortenedUrl.sanitize(url_client)
        expect(url).to eq("http://google.fr/")
      end
    end


    describe "expiration_date" do # Create an entry first then pass the test
      it "should return a add days to the expiration date" do
        url_client = "http://google.fr/"
        url = ShortenedUrl.sanitize(url_client)
        expect(url).to eq("http://google.fr/")
      end
    end


    describe "date_is_valid?" do # Create an entry first then pass the test
      it "should return a add days to the expiration date" do
        url_client = "http://google.fr/"
        url = ShortenedUrl.sanitize(url_client)
        expect(url).to eq("http://google.fr/")
      end
    end

  end
end
