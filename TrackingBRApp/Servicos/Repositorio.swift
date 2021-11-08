//
//  Repositorio.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import Foundation

// MARK: - httpMetodo

private enum httpMetodo: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - ErroRepositorio

enum ErroRepositorio: Error {
    case urlInvalida
    case dadosInvalidos
    case erroGenerico
    case erroDecodificacao
}

// MARK: - Repositorio

final class Repositorio {
    // MARK: Internal

    func obterDados() {
        let config = URLSessionConfiguration.default
        let sessao = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        guard let url = URL(string: "https://api.frenet.com.br/tracking/trackinginfo") else { return }

        var requisicao = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 0)
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requisicao.addValue("application/json", forHTTPHeaderField: "Accept")
        requisicao.addValue("583DBD18REA52R4F92RB6B4R407280A80A9F", forHTTPHeaderField: "token")

        let requisicaoBody = Requisicao(OrderNumber: "",
                                        ShippingServiceCode: "04227",
                                        InvoiceNumber: "",
//                                        TrackingNumber: "LB466560165SE",
                                        TrackingNumber: "NX409895735BR",
                                        InvoiceSerie: "",
                                        RecipientDocument: "")

        guard let jsonDados = converterJsonParaDados(requisicao: requisicaoBody) else { return }

        requisicao.httpBody = jsonDados
        requisicao.httpMethod = httpMetodo.post.rawValue

        let tarefa = sessao.dataTask(with: requisicao) { dados, resposta, erro in
            if let erro = erro {
                print("==36===:  erro", erro)
            }

            guard let dados = dados else { return }

            let resultado: Rastreio? = dados.decodificar()
            guard let rastreio = resultado else { return }
            print("==26===:  rastreio", rastreio)
            rastreio.trackingEvents?.forEach { print($0.eventDateTime) }
        }
        tarefa.resume()
    }

    // MARK: Private


    private func converterJsonParaDados(requisicao: Requisicao) -> Data? {
        do {
            return try JSONEncoder().encode(requisicao)
        } catch {
            print("==6===:  error", error)
            return nil
        }
    }
}

extension DateFormatter {
    static let converterStringParaData: DateFormatter = {
        let formatador = DateFormatter()
        formatador.dateFormat = "dd/MM/yyyy hh:mm"
        formatador.calendar = Calendar(identifier: .iso8601)
        formatador.timeZone = TimeZone(secondsFromGMT: 0)
        formatador.locale = Locale.current
        return formatador
    }()
}

extension Data {
    func decodificar<T: Codable>() -> T? {
        let decodificador = JSONDecoder()
        decodificador.dateDecodingStrategy = .formatted(.converterStringParaData)
        do {
            let resultado = try decodificador.decode(T.self, from: self)
            return resultado
        } catch {
            print("==49===:  error", error)
            return nil
        }
    }
}
