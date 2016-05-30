class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization

  def serialize_all(collection, serializer_class)
      collection.map do |item|
        serializer_class.send(:new, item)
      end
  end

  def respond_json(value, options = {})
    default_options = { request: request}

    respond_with value, default_options.merge(options)
  end
end
