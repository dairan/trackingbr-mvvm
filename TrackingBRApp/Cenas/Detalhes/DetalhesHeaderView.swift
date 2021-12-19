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
        guard let cidade = viewModel!.rastreamento?.trackingEvents?[indice.row].eventLocation else { return }
        localizar(cidade)
    }

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

    private func tracarLinha() {
        guard let cidades = viewModel?.rastreamento?.trackingEvents else { return }

        let cidadesFiltradas = cidades.filter { $0.eventLocation != "-" }

        let cidadesSelecionadas = cidadesFiltradas.map(\.eventLocation)

        guard let cidade1 = cidadesSelecionadas.first else { return }
        guard let cidade2 = cidadesSelecionadas.last else { return }

        let cidadess = [cidade1, cidade2]

        var anotacoes: [MKPointAnnotation] = []
        var coordenadas2d: [CLLocationCoordinate2D] = []

        for cidade in cidadess {
            let anotacao = MKPointAnnotation()
            anotacao.title = cidade

            DispatchQueue.main.async {
                let geodecoder = CLGeocoder()
                geodecoder.geocodeAddressString(cidade) { locais, _ in
                    if let coordenada = locais?.first?.location {
                        let coordenada2d = CLLocationCoordinate2D(latitude: coordenada.coordinate.latitude, longitude: coordenada.coordinate.longitude)
                        anotacao.coordinate = coordenada2d
                        coordenadas2d.append(coordenada2d)
                    }

                    let linha = MKPolyline(coordinates: coordenadas2d, count: 2)

                    anotacoes.append(anotacao)
                    self.mapaView.showAnnotations(anotacoes, animated: true)
                    self.mapaView.addOverlay(linha)
                }
            }
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
                                                      latitudinalMeters: 500,
                                                      longitudinalMeters: 500)
            let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: coordenadaRegion)

            let zoom = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 20000)

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
        let linha = MKPolylineRenderer(overlay: overlay)
        linha.lineWidth = 3
        linha.strokeColor = .systemRed
        return linha
    }
}
