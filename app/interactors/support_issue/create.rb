class SupportIssue::Create
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    SupportIssue.create(params.merge(user: user))
  end
end
