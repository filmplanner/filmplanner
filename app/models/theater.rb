class Theater < ApplicationRecord
  include Keyable

  has_many :shows
end
