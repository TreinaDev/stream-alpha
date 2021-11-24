module ErrorsHelper
  def field_errors(object, field)
    object.errors.full_messages_for(field).each do |message|
      message
    end
  end
end
