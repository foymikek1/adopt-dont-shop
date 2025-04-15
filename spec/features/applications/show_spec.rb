require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: "Dooby", age: 4, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(name: "Bob", address: "300 Power St", city: "Erie", state: "CO", zip_code: 91638, description: "Good fur-parent.", status: 0)
    @app_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    @app_pet_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
  end
  it "shows the application and all it's attributes" do
    # When I visit an applications show page
    visit "/applications/#{@application.id}"
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content(@application.full_address)
    expect(page).to have_content(@application.description)
    # Then I can see the following:
    # - Name of the Applicant
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content(@application.name)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
    expect(page).to have_content(@application.status) # "Pending"
  end

  it 'searches for pets to add to application' do
    @pet_3 = Pet.create!(name: "Scooby", age: 4, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    #As a visitor
    #When I visit an application's show page
    visit "/applications/#{@application.id}"
    #And that application has not been submitted,
    expect(page).to have_content("Add a Pet to this Application")
    #Then I see a section on the page to "Add a Pet to this Application"
    #In that section I see an input where I can search for Pets by name
    #When I fill in this field with a Pet's name
    fill_in "Search", with: "Scooby"
    #And I click submit,
    click_on "Submit"
    #Then I am taken back to the application show page
    expect(page).to have_current_path("/applications/#{@application.id}?search=Scooby&commit=Submit")
    #And under the search bar I see any Pet whose name matches my search
    expect(page).to have_content(@pet_1.name)
  end
end

