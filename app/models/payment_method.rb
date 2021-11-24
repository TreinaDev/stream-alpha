class PaymentMethod
  attr_accessor :name, :status
  def initialize(params)
    @name = params[:name]
    @status = params[:status]
  end

  def self.all
    result = []
    response = Faraday.get("http://pagapaga.com.br/api/v1/payment_methods/")
    if response.status == 200
      data = JSON.parse(response.body, symbolize_names: true)
      data.each do |d|
        result << PaymentMethod.new(d)
      end
    end
    result
  end
end