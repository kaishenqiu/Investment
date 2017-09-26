//
//  InvestModel.swift
//
//  Created by 邱仙凯 on 2017/9/26
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
public struct InvestModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let projectName = "project_name"
    static let status = "status"
    static let bidTime = "bid_time"
    static let money = "money"
    static let expectMoney = "expect_money"
    static let orderNo = "order_no"
    static let oProjectId = "o_project_id"
    static let termDay = "term_day"
    static let endDate = "end_date"
  }

  // MARK: Properties
  public var projectName: String?
  public var status: String?
  public var bidTime: String?
  public var money: String?
  public var expectMoney: String?
  public var orderNo: String?
  public var oProjectId: String?
  public var termDay: String?
  public var endDate: String?

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
    projectName = json[SerializationKeys.projectName].string
    status = json[SerializationKeys.status].string
    bidTime = json[SerializationKeys.bidTime].string
    money = json[SerializationKeys.money].string
    expectMoney = json[SerializationKeys.expectMoney].string
    orderNo = json[SerializationKeys.orderNo].string
    oProjectId = json[SerializationKeys.oProjectId].string
    termDay = json[SerializationKeys.termDay].string
    endDate = json[SerializationKeys.endDate].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = projectName { dictionary[SerializationKeys.projectName] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = bidTime { dictionary[SerializationKeys.bidTime] = value }
    if let value = money { dictionary[SerializationKeys.money] = value }
    if let value = expectMoney { dictionary[SerializationKeys.expectMoney] = value }
    if let value = orderNo { dictionary[SerializationKeys.orderNo] = value }
    if let value = oProjectId { dictionary[SerializationKeys.oProjectId] = value }
    if let value = termDay { dictionary[SerializationKeys.termDay] = value }
    if let value = endDate { dictionary[SerializationKeys.endDate] = value }
    return dictionary
  }

}
