class Theater < ApplicationRecord
  include Keyable

  PATHE = 'pathe'.freeze

  has_many :shows

  scope :pathe, -> { where(chain: PATHE) }
end
