class PaymentMethod
  attr_accessor :name, :status
  def initialize(params)
    @name = params[:name]
    @status = params[:status]
  end

  def self.all
  end
end