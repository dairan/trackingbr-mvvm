//
//  APIError.swift
//  TrackingBRApp
//
//  Created by Dairan on 15/10/21.
//

import Foundation

// MARK: - APIErrorElement

struct APIError: Codable {
  let code: String
  let isInvalid: Bool
  let error: String
}
