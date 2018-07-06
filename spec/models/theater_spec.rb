require 'rails_helper'

RSpec.describe Theater do
  it { should have_many(:shows) }
end
