require 'rails_helper'

RSpec.describe '/payment_requests', type: :request do
  before(:each) do
    @payment_request_record = create(:payment_request_record)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get payment_requests_url
      expect(response).to be_successful
    end
  end

  describe 'POST /accept' do
    it 'accepts a payment request' do
      expect do
        post payment_request_accept_url(payment_request_id: @payment_request_record)
      end.to change { @payment_request_record.reload.status }.to('accepted')
         .and change(Events::PaymentRequest::Accepted, :count).by(1)
    end

    it 'redirects to the index page' do
      post payment_request_accept_url(payment_request_id: @payment_request_record)
      expect(response).to redirect_to(payment_requests_url)
    end
  end

  describe 'POST /rejected' do
    it 'accepts a payment request' do
      expect do
        post payment_request_reject_url(payment_request_id: @payment_request_record)
      end.to change { @payment_request_record.reload.status }.to('rejected')
         .and change(Events::PaymentRequest::Rejected, :count).by(1)
    end

    it 'redirects to the index page' do
      post payment_request_reject_url(payment_request_id: @payment_request_record)
      expect(response).to redirect_to(payment_requests_url)
    end
  end
end
