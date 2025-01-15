require 'rails_helper'

RSpec.describe "simulations/edit", type: :view do
  let(:simulation) {
    Simulation.create!()
  }

  before(:each) do
    assign(:simulation, simulation)
  end

  it "renders the edit simulation form" do
    render

    assert_select "form[action=?][method=?]", simulation_path(simulation), "post" do
    end
  end
end
