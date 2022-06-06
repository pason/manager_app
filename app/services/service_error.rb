class ServiceError
  attr_reader :payload, :error

  def initialize(payload, error)
    @payload = payload
    @error = error
  end

  def success?
    false
  end
end
