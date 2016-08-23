module Validator
  def success_with(message)
    { valid: true, message: message }

  end

  def fail_with(message)
    { valid: false, message: message }
  end
end
