# frozen_string_literal: true

class LineTransationComponent < ViewComponent::Base
  def initialize(name:, date:, value:, status:)
    @name = name
    @date = date
    @value = value
    @status = status_transition(status)
  end
  def status_transition status
    case status
    when 'success'
      "Pagamento efetuado de"
    when 'refund'
      "Pagmento recusado de"
    when 'falied'
      "Pagamento falhou de"
    end
  end
end
