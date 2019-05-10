require "application_system_test_case"

class ShortenedUrlsTest < ApplicationSystemTestCase
  setup do
    @shortened_url = shortened_urls(:one)
  end

  test "visiting the index" do
    visit shortened_urls_url
    assert_selector "h1", text: "Shortened Urls"
  end

  test "creating a Shortened url" do
    visit shortened_urls_url
    click_on "New Shortened Url"

    fill_in "Category", with: @shortened_url.category
    fill_in "Created at", with: @shortened_url.created_at
    fill_in "Expires at", with: @shortened_url.expires_at
    fill_in "Owner id", with: @shortened_url.owner_id_id
    fill_in "Owner type", with: @shortened_url.owner_type
    fill_in "Unique key", with: @shortened_url.unique_key
    fill_in "Updated at", with: @shortened_url.updated_at
    fill_in "Url", with: @shortened_url.url
    fill_in "Use count", with: @shortened_url.use_count
    click_on "Create Shortened url"

    assert_text "Shortened url was successfully created"
    click_on "Back"
  end

  test "updating a Shortened url" do
    visit shortened_urls_url
    click_on "Edit", match: :first

    fill_in "Category", with: @shortened_url.category
    fill_in "Created at", with: @shortened_url.created_at
    fill_in "Expires at", with: @shortened_url.expires_at
    fill_in "Owner id", with: @shortened_url.owner_id_id
    fill_in "Owner type", with: @shortened_url.owner_type
    fill_in "Unique key", with: @shortened_url.unique_key
    fill_in "Updated at", with: @shortened_url.updated_at
    fill_in "Url", with: @shortened_url.url
    fill_in "Use count", with: @shortened_url.use_count
    click_on "Update Shortened url"

    assert_text "Shortened url was successfully updated"
    click_on "Back"
  end

  test "destroying a Shortened url" do
    visit shortened_urls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shortened url was successfully destroyed"
  end
end
