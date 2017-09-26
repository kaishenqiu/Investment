//
//  GoodsModel.swift
//
//  Created by 邱仙凯 on 2017/9/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct GoodsModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let goodsNo = "goods_no"
    static let id = "id"
    static let heightReviews = "height_reviews"
    static let express = "express"
    static let goodsImg = "goods_img"
    static let brands = "brands"
    static let descriptionValue = "description"
    static let goodsName = "goods_name"
  }

  // MARK: Properties
  public var goodsNo: String?
  public var id: String?
  public var heightReviews: Int?
  public var express: String?
  public var goodsImg: String?
  public var brands: String?
  public var descriptionValue: String?
  public var goodsName: String?

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
    goodsNo = json[SerializationKeys.goodsNo].string
    id = json[SerializationKeys.id].string
    heightReviews = json[SerializationKeys.heightReviews].int
    express = json[SerializationKeys.express].string
    goodsImg = json[SerializationKeys.goodsImg].string
    brands = json[SerializationKeys.brands].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    goodsName = json[SerializationKeys.goodsName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = goodsNo { dictionary[SerializationKeys.goodsNo] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = heightReviews { dictionary[SerializationKeys.heightReviews] = value }
    if let value = express { dictionary[SerializationKeys.express] = value }
    if let value = goodsImg { dictionary[SerializationKeys.goodsImg] = value }
    if let value = brands { dictionary[SerializationKeys.brands] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = goodsName { dictionary[SerializationKeys.goodsName] = value }
    return dictionary
  }

}
