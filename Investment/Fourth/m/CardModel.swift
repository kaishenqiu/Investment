//
//  CardModel.swift
//
//  Created by 邱仙凯 on 2017/9/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct CardModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let bankNo = "bank_no"
    static let bankNm = "bank_nm"
    static let id = "id"
    static let accountNm = "account_nm"
  }

  // MARK: Properties
  public var bankNo: String?
  public var bankNm: String?
  public var id: String?
  public var accountNm: String?

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
    bankNo = json[SerializationKeys.bankNo].string
    bankNm = json[SerializationKeys.bankNm].string
    id = json[SerializationKeys.id].string
    accountNm = json[SerializationKeys.accountNm].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = bankNo { dictionary[SerializationKeys.bankNo] = value }
    if let value = bankNm { dictionary[SerializationKeys.bankNm] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = accountNm { dictionary[SerializationKeys.accountNm] = value }
    return dictionary
  }

}
