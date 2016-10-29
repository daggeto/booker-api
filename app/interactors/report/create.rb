class Report::Create
  include Interactor::Initializer

  initialize_with :service, :reporter, :message

  def run
    Report.create(service: service, reporter: reporter, message: message)
  end
end
