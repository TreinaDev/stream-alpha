class PaymentMethod
  attr_accessor :name, :status

  def initialize(params)
    @name = params[:name]
    @status = params[:status]
  end

  def self.all
    result = []
    response = Faraday.get('http://pagapaga.com.br/api/v1/payment_methods/', nil,
                           { company_token: SecureRandom.alphanumeric(20) })
    return if response.status == 500

    if response.status == 200
      data = JSON.parse(response.body, symbolize_names: true)
      data.each { |d| result << PaymentMethod.new(d) }
    end
    result
  end
end
