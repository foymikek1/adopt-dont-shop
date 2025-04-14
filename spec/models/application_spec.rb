require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    application = Application.create!(name: "Bob", address: "300 Power St", city: "Erie", state: "CO", zip_code: 91638, description: "Good fur-parent.", status: 0)
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { expect(application.status).to eq("In_progress") }
  end
end
