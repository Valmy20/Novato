class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    regex_email = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    message = 'Email inválido!'
    record.errors[attribute] << (options[:message] || message) unless value =~ regex_email
  end
end
