class Movie < ApplicationRecord
  include Keyable

  has_many :shows
end
