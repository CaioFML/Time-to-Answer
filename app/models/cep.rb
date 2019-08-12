require 'net/http'
class CEP
  attr_reader :logradouro, :bairro, :localidade, :uf
  END_POINT = "https://viacep.com.br/ws/"
  FORMAT = "json"

  def initialize(cep)
    cep_encontrado = encontrar(cep) # hash
    preencher_dados(cep_encontrado)
  end

  def endereco
    "#{@logradouro} / #{@bairro} / #{@localidade} - #{@uf}"
  end

  private

  def preencher_dados(cep_encontrado)
    @logradouro = cep_encontrado["logradouro"]
    @bairro = cep_encontrado["bairro"]
    @localidade = cep_encontrado["localidade"]
    @uf = cep_encontrado["uf"]
  end

  def encontrar(cep)
    ActiveSupport::JSON.decode(
      Net::HTTP.get(
        URI("#{END_POINT}#{cep}/#{FORMAT}/")
      )
    )
  end
end