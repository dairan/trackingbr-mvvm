//
//  DTFLabel.swift
//  TrackingBR
//
//  Created by Dairan on 22/08/21.
//

import UIKit

class DTFLabel: UILabel {
  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configurar(texto: String) {
    text = texto
  }
}
