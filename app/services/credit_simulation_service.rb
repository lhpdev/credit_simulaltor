
class CreditSimulationService
  attr_reader :loan_value, :term_in_months, :birthdate, :user_id, :simulation_id, :yearly_tax

  def initialize(loan_value:, birthdate:, term_in_months:, user_id:, simulation_id:)
    @loan_value = loan_value
    @birthdate = birthdate
    @term_in_months = term_in_months
    @user_id = user_id
    @simulation_id = simulation_id
    @yearly_tax = determine_yearly_tax
  end

  def call
    monthly_payment = calculate_fixed_installment
    total_amount = (monthly_payment * term_in_months).round(2)
    
    SimulationProposal.create(
      total_amount: total_amount,
      monthly_payment: monthly_payment.round(2),
      total_fees: (total_amount - loan_value).round(2),
      user_id: user_id,
      simulation_id: simulation_id
    )
  end

  private

  def determine_yearly_tax
    age_brackets = { 0..25 => 0.05, 26..40 => 0.03, 41..60 => 0.02, 61..Float::INFINITY => 0.04 }
    age_brackets.find { |range, _| range.include?(age) }&.last || 0.04
  end

  def age
    @age ||= begin
      today = Date.today
      calculated_age = today.year - birthdate.year
      calculated_age -= 1 if today < birthdate + calculated_age.years
      calculated_age
    end
  end

  def calculate_fixed_installment
    monthly_tax = yearly_tax / 12.0
    return loan_value / term_in_months if monthly_tax.zero?

    (loan_value * monthly_tax) / (1 - (1 + monthly_tax) ** -term_in_months)
  end
end