require 'rails_helper'

RSpec.describe "simulations/show", type: :view do
  before(:each) do
    assign(:simulation, Simulation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
