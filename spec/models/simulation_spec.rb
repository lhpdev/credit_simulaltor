require 'rails_helper'

RSpec.describe Simulation, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value).is_greater_than(0) }

    it { should validate_presence_of(:birthdate) }

    it { should validate_presence_of(:term_in_months) }
    it { should validate_numericality_of(:term_in_months).only_integer.is_greater_than(0) }
  end

  describe "#proposals" do
    let(:simulation) { create(:simulation, user: create(:user)) }
    let!(:proposal1) { SimulationProposal.create(
      total_amount: 10000,
      monthly_payment: 120.round(2),
      total_fees: 200.00,
      user_id: simulation.user_id,
      simulation_id: simulation.id) 
    } 
    let!(:proposal2) { SimulationProposal.create(
      total_amount: 10000,
      monthly_payment: 120.round(2),
      total_fees: 100.00,
      user_id: simulation.user_id,
      simulation_id: simulation.id) 
    } 

    it "returns all associated proposals" do
      expect(simulation.proposals).to match_array([proposal1, proposal2])
    end
  end
end
