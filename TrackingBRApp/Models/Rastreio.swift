//
//  Rastreio.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//
//   let rastreio = try? newJSONDecoder().decode(Rastreio.self, from: jsonData)

import Foundation

// MARK: - Rastreio

struct Rastreio: Codable {
    let trackingNumber, serviceDescrition: String?
    let errorMessage: String?
    let trackingEvents: [TrackingEvent]?
    let carrier, carrierCode: String?
    let shippingDate: String?
    let maxDeliveryTime: Int?
    let estimatedDate, attempt, destination, origin: String?

    enum CodingKeys: String, CodingKey {
        case trackingNumber
        case serviceDescrition
        case errorMessage
        case trackingEvents
        case carrier
        case carrierCode
        case shippingDate
        case maxDeliveryTime
        case estimatedDate
        case attempt
        case destination
        case origin
    }
}

// MARK: - TrackingEvent

struct TrackingEvent: Codable {
    let sortDateTime: String?
    let eventDateTime: Date
    var eventLocation, eventDescription, eventType: String
    let eventStatus, carrierEvent, carrierStatus: String?

    enum CodingKeys: String, CodingKey {
        case sortDateTime
        case eventDateTime
        case eventLocation
        case eventDescription
        case eventType
        case eventStatus
        case carrierEvent
        case carrierStatus
    }
}

struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
