//
//  HeaderEncomendaTableViewCell.swift
//  TrackingBRApp
//
//  Created by Dairan on 29/09/21.
//

import MapKit
import UIKit

class DetalhesHeaderView: UITableViewHeaderFooterView {
    // MARK: Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configurarGeral()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal
    static let identificador = "HeaderEncomenda"

    func configuraDados(viewModel: DetalhesViewModel) {
        self.viewModel = viewModel
        guard let cidade = viewModel.rastreamento?.trackingEvents?.first?.eventLocation else { return }
//        localizar(cidade)
        tracarLinha()
    }

    func atualizarCidade(no indice: IndexPath) {
        guard let viewModel = viewModel else { return }
        guard let cidade = viewModel.rastreamento?.trackingEvents?[indice.row].eventLocation else { return }
        localizar(cidade)
    }

    func pontuarNoMapa() {}

    // MARK: Private
    private var viewModel: DetalhesViewModel?
    private lazy var mapaView: MKMapView = {
        let mapa = MKMapView()
        mapa.translatesAutoresizingMaskIntoConstraints = false
        mapa.delegate = self
        return mapa
    }()

    private lazy var codigoLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição do produto até duas linhas."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var anotacoes: [MKPointAnnotation] = []

    private func tracarLinha() {
        guard let todasCidades = viewModel?.rastreamento?.trackingEvents else { return }

        let cidadesFiltradas = todasCidades.filter { $0.eventLocation != "-" }
        let cidadesSelecionadas = cidadesFiltradas.map(\.eventLocation)

        guard let primeiraCidade = cidadesSelecionadas.last else { return }
        guard let ultimaCidade = cidadesSelecionadas.first else { return }

        let cidades = [primeiraCidade, ultimaCidade]

        var coordenadas2d: [CLLocationCoordinate2D] = []

        for cidade in cidades {
            geolocalizacao(cidade) { resultado in
                switch resultado {
                    case let .success(cidade):
                        coordenadas2d.append(cidade)
                        let linha = MKPolyline(coordinates: coordenadas2d, count: coordenadas2d.count)
                        self.mapaView.showAnnotations(self.anotacoes, animated: true)
                        self.mapaView.addOverlay(linha)
                    case let .failure(erro):
                        print("==32===:  erro", erro)
                }
            }
        }
    }

    private func geolocalizacao(_ cidade: String, aoTerminar: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geoDecoder = CLGeocoder()
        geoDecoder.geocodeAddressString(cidade) { locais, erro in
            guard let localizacao = locais?.first?.location else {
                aoTerminar(.failure(erro!))
                return
            }
            let anotacao = MKPointAnnotation()
            anotacao.title = cidade
            anotacao.coordinate.latitude = localizacao.coordinate.latitude
            anotacao.coordinate.longitude = localizacao.coordinate.longitude
            self.anotacoes.append(anotacao)
            let localizacao2d = CLLocationCoordinate2D(latitude: anotacao.coordinate.latitude,
                                                       longitude: anotacao.coordinate.longitude)
            aoTerminar(.success(localizacao2d))
        }
    }

    private func localizar(_ cidade: String) {
        let geodecoder = CLGeocoder()
        geodecoder.geocodeAddressString(cidade) { locais, erro in
            guard erro == nil else {
                print("==28===:  erro", erro as Any)
                return
            }

            guard let local = locais?.first else { return }
            guard let coordenada = local.location?.coordinate else { return }

            let coordenadaRegion = MKCoordinateRegion(center: coordenada,
                                                      latitudinalMeters: 1500,
                                                      longitudinalMeters: 1500)
            let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: coordenadaRegion)

            let zoom = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100_000)

            DispatchQueue.main.async {
                self.mapaView.region.span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                self.mapaView.setCameraBoundary(cameraBoundary, animated: true)
                self.mapaView.setCameraZoomRange(zoom, animated: true)
            }
        }
    }
}

// MARK: - ViewCode
extension DetalhesHeaderView: ViewCode {
    func configurar() {
        contentView.addSubview(codigoLabel)
        contentView.addSubview(mapaView)
    }

    func configurarView() {}

    func configurarConstraits() {
        NSLayoutConstraint.activate([
            codigoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            codigoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            mapaView.topAnchor.constraint(equalTo: topAnchor),
            mapaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapaView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - MKMapViewDelegate
extension DetalhesHeaderView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 3
        render.strokeColor = .systemRed
        return render
    }
}
