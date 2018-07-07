module Keyable
  extend ActiveSupport::Concern

  included do
    scope :for_key, ->(key) { where(id: SuggestionKey.new(key).ids) }
  end

  class_methods do
    def key_for(id)
      "#{name[0]}#{id}"
    end
  end

  def to_key
    self.class.key_for(id)
  end
end
