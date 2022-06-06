class PaymentRequestsController < ApplicationController
  before_action :set_payment_request_record, only: %i[accept reject]

  def index
    @payment_requests = PaymentRequestRecord.all.order(:created_at)
  end

  def accept
    @event = Events::PaymentRequest::Accepted.new
    @service = PaymentRequest::AcceptService.new(payment_request_record: @payment_request_record,
                                                 event: @event)
    if @service.perform.success?
      @event.publish
      redirect_to payment_requests_url, notice: 'Payment request was successfully accepted.'
    else
      redirect_to payment_requests_url, alert: 'Something went wrong. Please try again later.'
    end
  end

  def reject
    @event = Events::PaymentRequest::Rejected.new
    @service = PaymentRequest::RejectService.new(payment_request_record: @payment_request_record,
                                                 event: @event)
    if @service.perform.success?
      @event.publish
      redirect_to payment_requests_url, notice: 'Payment request was successfully rejected.'
    else
      redirect_to payment_requests_url, alert: 'Something went wrong. Please try again later.'
    end
  end

  private

  def set_payment_request_record
    @payment_request_record = PaymentRequestRecord.find(params[:payment_request_id])
  end
end
