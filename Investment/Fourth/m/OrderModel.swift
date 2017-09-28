//
//  OrderModel.swift
//
//  Created by 邱仙凯 on 2017/9/28
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct OrderModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let distribution = "distribution"
    static let invoice = "invoice"
    static let express = "express"
    static let updatedAt = "updated_at"
    static let totalFee = "total_fee"
    static let orderNo = "order_no"
    static let number = "number"
    static let orderType = "order_type"
    static let payFee = "pay_fee"
    static let displayOrder = "display_order"
    static let status = "status"
    static let id = "id"
    static let coupon = "coupon"
    static let discountFee = "discount_fee"
    static let createdAt = "created_at"
    static let rn = "rn"
    static let isRate = "is_rate"
    static let goodsitems = "goodsitems"
    static let userId = "user_id"
    static let activities = "activities"
  }

  // MARK: Properties
  public var distribution: Any?
  public var invoice: String?
  public var express: String?
  public var updatedAt: String?
  public var totalFee: String?
  public var orderNo: String?
  public var number: String?
  public var orderType: String?
  public var payFee: String?
  public var displayOrder: String?
  public var status: String?
  public var id: Int?
  public var coupon: String?
  public var discountFee: String?
  public var createdAt: String?
  public var rn: String?
  public var isRate: String?
  public var goodsitems: Array<[String:Any]>?
  public var userId: String?
  public var activities: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    distribution =  json[SerializationKeys.distribution].dictionaryValue
    invoice = json[SerializationKeys.invoice].string
    express = json[SerializationKeys.express].string
    updatedAt = json[SerializationKeys.updatedAt].string
    totalFee = json[SerializationKeys.totalFee].string
    orderNo = json[SerializationKeys.orderNo].string
    number = json[SerializationKeys.number].string
    orderType = json[SerializationKeys.orderType].string
    payFee = json[SerializationKeys.payFee].string
    displayOrder = json[SerializationKeys.displayOrder].string
    status = json[SerializationKeys.status].string
    id = json[SerializationKeys.id].int
    coupon = json[SerializationKeys.coupon].string
    discountFee = json[SerializationKeys.discountFee].string
    createdAt = json[SerializationKeys.createdAt].string
    rn = json[SerializationKeys.rn].string
    isRate = json[SerializationKeys.isRate].string
    goodsitems = json[SerializationKeys.goodsitems].arrayObject as! Array<[String : Any]>
    userId = json[SerializationKeys.userId].string
    activities = json[SerializationKeys.activities].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = distribution { dictionary[SerializationKeys.distribution] = value }
    if let value = invoice { dictionary[SerializationKeys.invoice] = value }
    if let value = express { dictionary[SerializationKeys.express] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = totalFee { dictionary[SerializationKeys.totalFee] = value }
    if let value = orderNo { dictionary[SerializationKeys.orderNo] = value }
    if let value = number { dictionary[SerializationKeys.number] = value }
    if let value = orderType { dictionary[SerializationKeys.orderType] = value }
    if let value = payFee { dictionary[SerializationKeys.payFee] = value }
    if let value = displayOrder { dictionary[SerializationKeys.displayOrder] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = coupon { dictionary[SerializationKeys.coupon] = value }
    if let value = discountFee { dictionary[SerializationKeys.discountFee] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = rn { dictionary[SerializationKeys.rn] = value }
    if let value = isRate { dictionary[SerializationKeys.isRate] = value }
    if let value = goodsitems { dictionary[SerializationKeys.goodsitems] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = activities { dictionary[SerializationKeys.activities] = value }
    return dictionary
  }

}
