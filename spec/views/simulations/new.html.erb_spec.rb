require 'rails_helper'

RSpec.describe "simulations/new", type: :view do
  before(:each) do
    assign(:simulation, Simulation.new())
  end

  it "renders new simulation form" do
    render

    assert_select "form[action=?][method=?]", simulations_path, "post" do
    end
  end
end
