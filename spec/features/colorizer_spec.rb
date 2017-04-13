require 'colorizer'

describe 'test color' do

  it 'expected red text' do
    colorizer = EqJsonColorizer.new()
    expect("\e[31mtest42\e[0m").to eq(colorizer.red("test42"))
  end

  it 'expected green text' do
    colorizer = EqJsonColorizer.new()
    expect("\e[32mtest42\e[0m").to eq(colorizer.green("test42"))
  end

  it 'expected blue text' do
    colorizer = EqJsonColorizer.new()
    expect("\e[34mtest42\e[0m").to eq(colorizer.blue("test42"))
  end
end
