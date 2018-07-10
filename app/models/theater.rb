class Theater < ApplicationRecord
  include Keyable
  include Chainable

  has_many :shows
end
