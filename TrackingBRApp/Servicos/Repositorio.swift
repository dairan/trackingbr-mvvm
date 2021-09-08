//
//  Repositorio.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import Foundation

class Repositorio {
  private let urlString = "https://trackingbr.dairan.com/v1/codigo/LB466560165SE"

  func verificar(aoTerminar: @escaping (Result<Rastreio, Error>) -> Void) {
    guard let url = URL(string: urlString) else { fatalError() }

    let tarefa = URLSession.shared.dataTask(with: url) { dados, resposta, erro in
      guard let dados = dados else { fatalError() }

      let decode = JSONDecoder()
      do {
        let rastreio = try decode.decode([Rastreio].self, from: dados)
        aoTerminar(.success(rastreio.first!))
      } catch {
        aoTerminar(.failure(error))
      }
    }
    tarefa.resume()
  }
}
