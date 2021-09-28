//
//  TextFieldFactory.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

protocol TextFieldFactory {
  func criarTextField(comPlaceholder placeholder: String, corBackground cor: UIColor) -> UITextField
}
