//
//  LeftModel.swift
//
//  Created by 邱仙凯 on 2017/9/7
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct LeftModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let no = "no"
    static let img = "img"
    static let name = "name"
    static let paperPassed = "paper_passed"
    static let money = "money"
    static let termDay = "term_day"
    static let accrual = "accrual"
    static let rn = "rn"
    static let investMoney = "invest_money"
    static let startDate = "start_date"
    static let endDate = "end_date"
    static let properties = "properties"
  }

  // MARK: Properties
  public var no: String?
  public var img: String?
  public var name: String?
  public var paperPassed: String?
  public var money: String?
  public var termDay: String?
  public var accrual: String?
  public var rn: String?
  public var investMoney: String?
  public var startDate: String?
  public var endDate: String?
  public var properties: String?

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
    no = json[SerializationKeys.no].string
    img = json[SerializationKeys.img].string
    name = json[SerializationKeys.name].string
    paperPassed = json[SerializationKeys.paperPassed].string
    money = json[SerializationKeys.money].string
    termDay = json[SerializationKeys.termDay].string
    accrual = json[SerializationKeys.accrual].string
    rn = json[SerializationKeys.rn].string
    investMoney = json[SerializationKeys.investMoney].string
    startDate = json[SerializationKeys.startDate].string
    endDate = json[SerializationKeys.endDate].string
    properties = json[SerializationKeys.properties].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = no { dictionary[SerializationKeys.no] = value }
    if let value = img { dictionary[SerializationKeys.img] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = paperPassed { dictionary[SerializationKeys.paperPassed] = value }
    if let value = money { dictionary[SerializationKeys.money] = value }
    if let value = termDay { dictionary[SerializationKeys.termDay] = value }
    if let value = accrual { dictionary[SerializationKeys.accrual] = value }
    if let value = rn { dictionary[SerializationKeys.rn] = value }
    if let value = investMoney { dictionary[SerializationKeys.investMoney] = value }
    if let value = startDate { dictionary[SerializationKeys.startDate] = value }
    if let value = endDate { dictionary[SerializationKeys.endDate] = value }
    if let value = properties { dictionary[SerializationKeys.properties] = value }
    return dictionary
  }

}
