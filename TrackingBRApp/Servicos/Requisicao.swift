//
//  Requisicao.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/11/21.
//

import Foundation

struct Requisicao: Encodable {
    let OrderNumber: String
    let ShippingServiceCode: String
    let InvoiceNumber: String
    let TrackingNumber: String
    let InvoiceSerie: String
    let RecipientDocument: String
}
