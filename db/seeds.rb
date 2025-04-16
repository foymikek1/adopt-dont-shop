# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
puts "Seed start"
shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
pet_2 = Pet.create!(name: "Dooby", age: 4, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
application = Application.create!(name: "Bob", address: "300 Power St", city: "Erie", state: "CO", zip_code: 91638, description: "Good fur-parent.", status: 0)
app_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
app_pet_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
puts "Seed finished"