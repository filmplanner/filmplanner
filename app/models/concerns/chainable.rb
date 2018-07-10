module Chainable
  extend ActiveSupport::Concern

  included do
    scope :pathe, -> { where(chain: Chain::PATHE) }
  end
end
