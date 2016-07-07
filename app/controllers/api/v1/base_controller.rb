class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  # def update_auth_header
  #   # cannot save object if model has invalid params
  #   return unless @resource and @resource.valid? and @client_id
  #
  #   # Generate new client_id with existing authentication
  #   @client_id = nil unless @used_auth_by_token
  #
  #   if @used_auth_by_token and not DeviseTokenAuth.change_headers_on_each_request
  #     auth_header = @resource.build_auth_header(@token, @client_id)
  #
  #     # update the response header
  #     response.headers.merge!(auth_header)
  #
  #   else
  #
  #     # Lock the user record during any auth_header updates to ensure
  #     # we don't have write contention from multiple threads
  #     @resource.with_lock do
  #       # determine batch request status after request processing, in case
  #       # another processes has updated it during that processing
  #       @is_batch_request = is_batch_request?(@resource, @client_id)
  #
  #       auth_header = {}
  #       action = ""
  #
  #       # extend expiration of batch buffer to account for the duration of
  #       # this request
  #       if @is_batch_request
  #         auth_header = @resource.extend_batch_buffer(@token, @client_id)
  #         action = "batch"
  #         # update Authorization response header with new token
  #       else
  #         auth_header = @resource.create_new_auth_token(@client_id)
  #         # update the response header
  #         action ="new"
  #         response.headers.merge!(auth_header)
  #       end
  #       result = {
  #         action: action,
  #         auth_header: auth_header,
  #         updated_at: @resource.tokens[@client_id]['updated_at'],
  #         current_token_hash: @resource.tokens[@client_id]['token'],
  #         last_token: @resource.tokens[@client_id]['last_token']
  #       }
  #
  #       logger.debug("[AFTER_REQUEST]: #{result.inspect}")
  #
  #     end # end lock
  #
  #   end
  #
  # end
end
