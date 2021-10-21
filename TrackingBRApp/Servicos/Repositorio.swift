//
//  Repositorio.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import Foundation

// MARK: - ErroRepositorio

enum ErroRepositorio: Error {
  case urlInvalida
  case dadosInvalidos
  case erroGenerico
  case erroDecodificacao
}

// MARK: - Repositorio

class Repositorio {
  // MARK: Internal

//  private let urlString = "https://hp-api.herokuapp.com/api/characters"

  func verificar(aoTerminar: @escaping (Result<Rastreio?, ErroRepositorio>) -> Void) {
    guard let url = URL(string: urlString) else { return aoTerminar(.failure(.urlInvalida)) }

    let tarefa = URLSession.shared.dataTask(with: url) { dados, resposta, erro in
      if let erro = erro {
        aoTerminar(.failure(.erroGenerico))
      }

      guard let dados = dados else { return aoTerminar(.failure(.dadosInvalidos)) }

      let rastreio = self.decodificar(os: dados)

      guard let rastreio = rastreio else { return aoTerminar(.failure(.erroDecodificacao)) }
      aoTerminar(.success(rastreio))
    }

    tarefa.resume()
  }

  func decodificar(os dados: Data) -> Rastreio? {
    let decodificador = JSONDecoder()
    do {
      let rastreios = try decodificador.decode([Rastreio].self, from: dados)
      return rastreios.first
    } catch {
      print("==49===:  error", error)
//      return ErroRepositorio.erroDecodificacao
      return nil
    }
  }

  // MARK: Private

  private var urlString = "https://trackingbr.dairan.com/v1/codigo/NX409895735BR"
}
