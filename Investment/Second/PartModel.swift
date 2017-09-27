//
//  PartModel.swift
//
//  Created by 邱仙凯 on 2017/9/27
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
public struct PartModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let wxprice = "wxprice"
    static let name = "name"
    static let stock = "stock"
    static let pno = "pno"
    static let ids = "ids"
    static let price = "price"
    static let number = "number"
  }

  // MARK: Properties
  public var wxprice: String?
  public var name: String?
  public var stock: String?
  public var pno: String?
  public var ids: String?
  public var price: String?
  public var number:Int?

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
    wxprice = json[SerializationKeys.wxprice].string
    name = json[SerializationKeys.name].string
    stock = json[SerializationKeys.stock].string
    pno = json[SerializationKeys.pno].string
    ids = json[SerializationKeys.ids].string
    price = json[SerializationKeys.price].string
    number = json[SerializationKeys.number].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = wxprice { dictionary[SerializationKeys.wxprice] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = stock { dictionary[SerializationKeys.stock] = value }
    if let value = pno { dictionary[SerializationKeys.pno] = value }
    if let value = ids { dictionary[SerializationKeys.ids] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = number { dictionary[SerializationKeys.number] = value}
    return dictionary
  }

}
