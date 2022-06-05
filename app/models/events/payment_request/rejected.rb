module Events
  module PaymentRequest
    class Rejected < PaymentRequestEvent
      include Publishable
      routing_key 'payment_request.rejected'.freeze
    end
  end
end
