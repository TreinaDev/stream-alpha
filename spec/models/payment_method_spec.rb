require 'rails_helper'

describe PaymentMethod, type: :model do
  context '.all' do
    it 'should return an array' do
      api_response = File.read(Rails.root.join('spec/support/apis/payment_methods.json'))
      fake_response = double('faraday_response', status: 200, body: api_response)
      allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('154689459647851263as')
      allow(Faraday).to receive(:get).with('http://pagapaga.com.br/api/v1/payment_methods/', nil, {company_token: '154689459647851263as'})
                                     .and_return(fake_response)

      result = PaymentMethod.all

      expect(result.length).to eq 3
      expect(result[0].name).to eq 'Boleto'
      expect(result[0].status).to eq 'Ativo'
      expect(result[1].name).to eq 'Cartão de crédito'
      expect(result[1].status).to eq 'Ativo'
      expect(result[2].name).to eq 'Pix'
      expect(result[2].status).to eq 'Ativo'
    end

    it 'should return nil if API returns 500' do
      fake_response = double('faraday_response', status: 500, body: '')

      allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('154689459647851263as')
      allow(Faraday).to receive(:get).with('http://pagapaga.com.br/api/v1/payment_methods/', nil, {company_token: '154689459647851263as'})
                                     .and_return(fake_response)

      result = PaymentMethod.all

      expect(result).to eq(nil)
    end
  end
end
