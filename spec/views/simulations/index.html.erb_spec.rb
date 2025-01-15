require 'rails_helper'

RSpec.describe "simulations/index", type: :view do
  before(:each) do
    assign(:simulations, [
      Simulation.create!(),
      Simulation.create!()
    ])
  end

  it "renders a list of simulations" do
    render
    cell_selector = 'div>p'
  end
end
