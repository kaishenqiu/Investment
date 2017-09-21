//
//  AddrModel.swift
//
//  Created by 邱仙凯 on 2017/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct AddrModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let district = "district"
    static let city = "city"
    static let updatedAt = "updated_at"
    static let mobile = "mobile"
    static let tag = "tag"
    static let address = "address"
    static let realname = "realname"
    static let province = "province"
    static let zipcode = "zipcode"
    static let status = "status"
    static let defau = "defau"
    static let id = "id"
    static let createdAt = "created_at"
    static let userId = "user_id"
    static let country = "country"
  }

  // MARK: Properties
  public var district: String?
  public var city: String?
  public var updatedAt: String?
  public var mobile: String?
  public var tag: String?
  public var address: String?
  public var realname: String?
  public var province: String?
  public var zipcode: String?
  public var status: String?
  public var defau: String?
  public var id: String?
  public var createdAt: String?
  public var userId: String?
  public var country: String?

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
    district = json[SerializationKeys.district].string
    city = json[SerializationKeys.city].string
    updatedAt = json[SerializationKeys.updatedAt].string
    mobile = json[SerializationKeys.mobile].string
    tag = json[SerializationKeys.tag].string
    address = json[SerializationKeys.address].string
    realname = json[SerializationKeys.realname].string
    province = json[SerializationKeys.province].string
    zipcode = json[SerializationKeys.zipcode].string
    status = json[SerializationKeys.status].string
    defau = json[SerializationKeys.defau].string
    id = json[SerializationKeys.id].string
    createdAt = json[SerializationKeys.createdAt].string
    userId = json[SerializationKeys.userId].string
    country = json[SerializationKeys.country].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = district { dictionary[SerializationKeys.district] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = mobile { dictionary[SerializationKeys.mobile] = value }
    if let value = tag { dictionary[SerializationKeys.tag] = value }
    if let value = address { dictionary[SerializationKeys.address] = value }
    if let value = realname { dictionary[SerializationKeys.realname] = value }
    if let value = province { dictionary[SerializationKeys.province] = value }
    if let value = zipcode { dictionary[SerializationKeys.zipcode] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = defau { dictionary[SerializationKeys.defau] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

}
