class CreditSimulationService
  attr_reader :loan_value, :yearly_tax, :terms_in_months, :birthdate

  def initialize(loan_value:, birthdate:, terms_in_months:)
    @loan_value = loan_value
    @birthdate = birthdate
    @terms_in_months = terms_in_months
    @yearly_tax = calculate_yearly_tax
  end

  def call
    total_fees = loan_value * yearly_tax * (terms_in_months / 12.0)
    total_amount = loan_value + total_fees
    monthly_payment = total_amount / terms_in_months

    {
      total_amount: total_amount.round(2),
      monthly_payment: monthly_payment.round(2),
      total_fees: total_fees.round(2)
    }
  end

  private

  def calculate_yearly_tax
    age = calculate_age

    case age
    when 0..25
      0.05
    when 26..40
      0.03
    when 41..60
      0.02
    else
      0.04
    end
  end

  def calculate_age
    today = Date.today
    age = today.year - birthdate.year
    age -= 1 if today < birthdate + age.years
    age
  end
end