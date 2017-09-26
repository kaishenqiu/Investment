//
//  RecordModel.swift
//
//  Created by 邱仙凯 on 2017/9/26
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct RecordModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let money = "money"
    static let usreNm = "usre_nm"
    static let bidTime = "bid_time"
  }

  // MARK: Properties
  public var money: String?
  public var usreNm: String?
  public var bidTime: String?

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
    money = json[SerializationKeys.money].string
    usreNm = json[SerializationKeys.usreNm].string
    bidTime = json[SerializationKeys.bidTime].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = money { dictionary[SerializationKeys.money] = value }
    if let value = usreNm { dictionary[SerializationKeys.usreNm] = value }
    if let value = bidTime { dictionary[SerializationKeys.bidTime] = value }
    return dictionary
  }

}
