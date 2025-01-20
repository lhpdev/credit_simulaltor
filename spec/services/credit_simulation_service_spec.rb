require 'rails_helper'

RSpec.describe CreditSimulationService, type: :service do
  let(:user) { create(:user) }
  let(:simulation) { create(:simulation, user: user) }
  let(:birthdate) { Date.new(1990, 1, 1) }
  let(:loan_value) { 10_000 }
  let(:term_in_months) { 24 }

  subject do
    described_class.new(
      loan_value: loan_value,
      birthdate: birthdate,
      term_in_months: term_in_months,
      user_id: user.id,
      simulation_id: simulation.id
    )
  end

  describe "#initialize" do
    it "assigns the correct attributes" do
      expect(subject.loan_value).to eq(BigDecimal(loan_value.to_s))
      expect(subject.birthdate).to eq(birthdate)
      expect(subject.term_in_months).to eq(term_in_months)
      expect(subject.user_id).to eq(user.id)
      expect(subject.simulation_id).to eq(simulation.id)
    end

    it "determines the correct yearly tax based on age" do
      expect(subject.yearly_tax).to eq(0.03) # Age 34 falls in 26-40 range
    end
  end

  describe "#call" do
    context "when no previous active proposals exist" do
      it "creates a new simulation proposal" do
        expect { subject.call }.to change { SimulationProposal.count }.by(1)

        proposal = SimulationProposal.last
        expect(proposal.user_id).to eq(user.id)
        expect(proposal.simulation_id).to eq(simulation.id)
        expect(proposal.total_amount).to be > loan_value
        expect(proposal.monthly_payment).to be > 0
        expect(proposal.total_fees).to eq((proposal.total_amount - loan_value).round(2))
      end
    end

    context "when previous active proposals exist" do
      let!(:old_proposal) { create(:simulation_proposal, simulation_id: simulation.id, valid_proposal: true) }

      it "deactivates previous proposals" do
        expect { subject.call }.to change { old_proposal.reload.valid_proposal }.from(true).to(false)
      end

      it "creates a new proposal" do
        expect { subject.call }.to change { SimulationProposal.count }.by(1)
      end
    end
  end

  describe "#calculate_fixed_installment" do
    it "calculates correct fixed installment for non-zero tax" do
      monthly_tax = subject.yearly_tax / 12.0
      expected_payment = (loan_value * monthly_tax) / (1 - (1 + monthly_tax) ** -term_in_months)
      expect(subject.send(:calculate_fixed_installment)).to eq(expected_payment)
    end
  end

  describe "#age" do
    it "calculates the correct age based on birthdate" do
      allow(Date).to receive(:today).and_return(Date.new(2024, 1, 1))
      expect(subject.send(:age)).to eq(34)
    end
  end

  describe "#determine_yearly_tax" do
    it "assigns correct tax based on age brackets" do
      {
        Date.new(2000, 1, 1) => 0.05,  # Age 24 → 5%
        Date.new(1990, 1, 1) => 0.03,  # Age 34 → 3%
        Date.new(1970, 1, 1) => 0.02,  # Age 54 → 2%
        Date.new(1950, 1, 1) => 0.04   # Age 74 → 4%
      }.each do |dob, expected_tax|
        service = described_class.new(
          loan_value: loan_value,
          birthdate: dob,
          term_in_months: term_in_months,
          user_id: user.id,
          simulation_id: simulation.id
        )
        expect(service.send(:determine_yearly_tax)).to eq(expected_tax)
      end
    end
  end
end
