class SuggestionKey
  class << self
    def join(keys)
      keys.uniq.sort.join('-')
    end

    def split(key)
      key.split('-')
    end

    def from_keys(keys)
      new(join(keys))
    end
  end

  def initialize(key)
    @key = key
  end

  def to_s
    @key
  end

  def keys
    SuggestionKey.split(@key)
  end

  def all_keys
    (1..keys.length).flat_map do |i|
      keys.combination(i).map { |combination| SuggestionKey.join(combination) }
    end
  end

  def ids
    keys.map { |key| key.gsub(/\D/, '').to_i }
  end
end
