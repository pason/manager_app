class ServiceSuccess
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def success?
    true
  end
end
