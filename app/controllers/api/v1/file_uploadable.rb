module Api::V1::FileUploadable
  # Need for file uploading
  def update_auth_header
    return unless @resource and @resource.valid? and @client_id

    @client_id = nil unless @used_auth_by_token

    @resource.with_lock do
      @resource.extend_batch_buffer(@token, @client_id)
    end # end lock
  end
end
