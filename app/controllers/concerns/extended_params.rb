module ExtendedParams
  def param_to_array(param)
    param.split(',').map(&:to_i)
  end
end
