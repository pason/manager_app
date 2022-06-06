require 'rails_helper'

RSpec.describe PaymentRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/payment_requests').to route_to('payment_requests#index')
    end

    it 'routes to #accept' do
      expect(post: '/payment_requests/abc/accept').to route_to('payment_requests#accept', payment_request_id: 'abc')
    end

    it 'routes to #reject' do
      expect(post: '/payment_requests/abc/reject').to route_to('payment_requests#reject', payment_request_id: 'abc')
    end
  end
end
