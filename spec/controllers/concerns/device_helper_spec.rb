class DummyController < ApplicationController
  include DeviceHelper
end

describe DummyController do
  let(:headers) { {} }
  let(:request) { double(headers: headers, env: {}, parameters: {}) }

  subject(:controller) { described_class.new }

  before { allow(controller).to receive(:request).and_return(request) }
end
