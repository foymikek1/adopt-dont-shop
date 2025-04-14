require "rails_helper"

RSpec.describe "the application new", type: :feature do
  describe "Starting an Application" do
    it "form not Completed" do
      # When I visit the new application page
      visit "/applications/new"
      # And I fail to fill in any of the form fields
      # And I click submit
      click_on "Submit"
      # Then I am taken back to the new applications page
      visit "/applications/new"

      # And I see a message that I must fill in those fields.
      expect(page).to have_content("Please fill in all form fields.")
    end
  end
end