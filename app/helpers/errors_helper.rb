module ErrorsHelper
  def error_plan(object, field)
    object.errors.full_messages_for(field).each do |message|
      message
    end
  end
end
