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

//    enum CodingKeys: String, CodingKey {
//        case trackingNumber = "TrackingNumber"
//        case serviceDescrition = "ServiceDescrition"
//        case errorMessage = "ErrorMessage"
//        case trackingEvents = "TrackingEvents"
//        case carrier = "Carrier"
//        case carrierCode = "CarrierCode"
//        case shippingDate = "ShippingDate"
//        case maxDeliveryTime = "MaxDeliveryTime"
//        case estimatedDate = "EstimatedDate"
//        case attempt = "Attempt"
//        case destination = "Destination"
//        case origin = "Origin"
//    }
}

// MARK: - TrackingEvent

struct TrackingEvent: Codable {
    let sortDateTime: String?
    let eventDateTime: Date
    var eventLocation, eventDescription, eventType: String
    let eventStatus, carrierEvent, carrierStatus: String?
}

struct AnyKey: CodingKey {

    static let vazia = AnyKey(stringValue: "")!

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
