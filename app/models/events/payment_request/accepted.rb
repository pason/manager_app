module Events
  module PaymentRequest
    class Accepted < PaymentRequestEvent
      include Publishable
      routing_key 'payment_request.accepted'.freeze
    end
  end
end
