require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: "Dooby", age: 4, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create!(name: "Ruby", age: 1, breed: "Border Collie", adoptable: true, shelter_id: @shelter.id)
    @pet_4 = Pet.create!(name: "Furby", age: 4, breed: "Pug X", adoptable: true, shelter_id: @shelter.id)
    @application_1 = Application.create!(name: "Bob", address: "300 Power St", city: "Erie", state: "CO", zip_code: 91638, description: "Good fur-parent.", status: 0)
    @application_2 = Application.create!(name: "Lauv", address: "300 Power St", city: "Erie", state: "CO", zip_code: 91638, description: "Good fur-parent.", status: 0)
    @app_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @app_pet_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_1.id)
  end

  it "shows the application and all it's attributes" do
    # When I visit an applications show page
    visit "/applications/#{@application_1.id}"
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content(@application_1.full_address)
    expect(page).to have_content(@application_1.description)
    # Then I can see the following:
    # - Name of the Applicant
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content(@application_1.name)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
    expect(page).to have_content(@application_1.status) # "Pending"
  end

  it 'searches for pets to add to application' do
    #As a visitor
    #When I visit an application's show page
    visit "/applications/#{@application_1.id}"
    #And that application has not been submitted,
    expect(page).to have_content("Add a Pet to this Application")
    #Then I see a section on the page to "Add a Pet to this Application"
    #In that section I see an input where I can search for Pets by name
    #When I fill in this field with a Pet's name
    fill_in "Search", with: "Scooby"
    #And I click submit,
    click_on "Submit"
    #Then I am taken back to the application show page
    expect(page).to have_current_path("/applications/#{@application_1.id}?search=Scooby&commit=Submit")
    #And under the search bar I see any Pet whose name matches my search
    expect(page).to have_content(@pet_1.name)
  end

  it 'can add a pet to an application' do
    expect(@pet_3.applications).to eq([])
    expect(@application_2.pets).to eq([])
    # Add a Pet to an Application
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    visit "/applications/#{@application_2.id}"
    require 'pry'; binding.pry
    fill_in "Search", with: "Ruby"
    click_on "Submit"
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    click_on "Apply for Ruby"
    # Then I am taken back to the application show page
    expect(page).to have_current_path("/applications/#{@application_2.id}")
    # And I see the Pet I want to adopt listed on this application
    expect(page).to have_content(@pet_3.name)
    expect(@pet_3.applications).to eq(@application_2)
    expect(@application_2.applications).to eq(@pet_3)
  end

  xit "submit's an application with pet" do
    # When I visit an application's show page
    visit "/applications/#{@application_1.id}"
    fill_in "Search", with: "Ruby"
    click_on "Submit"
    click_on "Apply for Ruby"
    expect(page).to have_current_path("/applications/#{@application_1.id}")
    expect(page).to have_content(@pet_3.name)
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    click_on "Submit Application"
    #do pet_app creation. 
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    fill_in "Description", with: "I already love Ruby."
    # And I click a button to submit this application
    click_on "Submit"
    #update application.description with why good owner for added pets
    # Then I am taken back to the application's show page
    expect(page).to have_current_path("/applications/#{@application_1.id}")
    # And I see an indicator that the application is "Pending"
    expect(page).to have_content("Pending")
    expect(page).to have_content(@pet_3.name)
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
    expect(page).to_not have_content("Add a Pet to this Application:")
  end
end

