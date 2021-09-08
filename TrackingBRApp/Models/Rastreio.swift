//
//  Rastreio.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//
//   let rastreio = try? newJSONDecoder().decode(Rastreio.self, from: jsonData)

import Foundation

// MARK: - RastreioElement

struct Rastreio: Codable {
  let code, type: String
  let tracks: [Track]
  let isDelivered: Bool
  let postedAt, updatedAt: String
}

// MARK: - Track

struct Track: Codable {
  let locale, status: String
  let observation: String?
  let trackedAt: String
}

