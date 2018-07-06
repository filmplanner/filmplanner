require 'rails_helper'

RSpec.describe Show do
  it { should belong_to(:movie) }
  it { should belong_to(:theater) }
end
