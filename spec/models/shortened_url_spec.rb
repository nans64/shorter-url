require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  before do
    @user = User.create!(email: "jean@highflyers.agency", password:"123456", password_confirmation: "123456")
    @url = Shortener::ShortenedUrl.generate("http://google.fr/", owner: User.last, fresh: true, expires_at: 72.hours.since)
    @url_client = "http://google.fr/"

  end

  context "model testing" do

    describe "sanitize" do
      it "should return a sanatize URL" do
        url = ShortenedUrl.sanitize(@url_client)
        expect(url).to eq("http://google.fr/")
      end
    end


    describe "add_days" do # Create an entry first then pass the test
      it "should return true and add the days number to the expiration date" do
        url = ShortenedUrl.add_days(@url.id, 5)
        expect(url).to eq(true)
      end
    end

    describe "expiration_date" do # Create an entry first then pass the test
      it "should return a add days to the expiration date" do
        url = ShortenedUrl.expire(@url.id, DateTime.now)
        expect(url).to eq(true)
      end
    end


    describe "date_is_valid?" do # Create an entry first then pass the test
      it "should return a add days to the expiration date" do
        url = ShortenedUrl.date_is_valid?(@url)
        expect(url).to eq(false)
      end
    end

  end

end

describe "Testing form", type: :feature do

  before do
    @user = User.create!(email: "jean@highflyers.agency", password:"123456", password_confirmation: "123456")
    @url = Shortener::ShortenedUrl.generate("http://google.fr/", owner: User.last, fresh: true, expires_at: 72.hours.since)
    @url_client = "http://google.fr/"

  end
  context "form testing" do

    describe "URL input testing" do

      it "add an input" do

        visit static_pages_path
        within('form') do
          fill_in 'input-url', with: 'http://google.fr/'
        end
        click_button 'input-submit'
        expect(page).to have_content "L'URL a été transformé avec succès"
      end

    end

  end

end