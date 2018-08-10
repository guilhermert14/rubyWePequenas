require 'ffaker'
require './features/support/pages/common.rb'

LOGIN = {
  usuarioGuilherme: {
    email:'guilhermeteste20@groove.tech',
    senha: 'teste2018'
  },
  usuarioBlackList: {
  email:'user_automacao03112014_090634513@cnova.com',
  senha: '123456'
  }
}

ENDERECO = {
    sucesso:{
      estado:"SP",
      regiao:"Capital",
      cidade: "o Paulo",
      bairro:"Cambuci",
      loja:"Casas Bahia"
    }
}

CARTAO = {
  master: {
    numero: 5567474977476697,
    dtValMes: 01,
    dtValAno: 2021,
    cvv: 111,
    nome: "Guilherme Reis"
  }
}
