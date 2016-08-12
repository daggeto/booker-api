class Service::Publish
  include Interactor::Initializer

  initialize_with :service

  def run
    service.update_attributes(published: true)
  end
end
