require 'rails_helper'

RSpec.describe Movie do
  it { should have_many(:shows) }
end
