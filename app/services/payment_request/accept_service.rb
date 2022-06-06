module PaymentRequest
  class AcceptService
    attr_reader :payment_request_record, :event

    def initialize(payment_request_record:, event:)
      @payment_request_record = payment_request_record
      @event = event
    end

    def perform
      ActiveRecord::Base.transaction do
        event.assign_attributes(payment_request_record: payment_request_record,
                                payload: event_payload)
        event.save!
        payment_request_record.accepted!
      end
      ServiceSuccess.new(event)
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => e
      ServiceError.new(event, e)
    end

    private

    def event_payload
      { id: payment_request_record.id }
    end
  end
end