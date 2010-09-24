module Sevendigital

class ApiRequest

  attr_reader :api_method, :parameters, :signed
  attr_accessor :token

  def initialize(api_method, parameters, options = {})
    @api_method = api_method
    @parameters = comb_parameters(options.merge(parameters))
  end

  def requires_signature?
    @signed == true
  end

  def require_signature
    @signed = true
  end

  def comb_parameters(parameters)
    page_size = parameters[:page_size] || parameters[:per_page]
    parameters[:pageSize] ||= page_size if page_size
    return parameters
  end

  def ensure_country_is_set(country)
    @parameters[:country] ||= country
  end

end

end