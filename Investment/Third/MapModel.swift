//
//  MapModel.swift
//
//  Created by 邱仙凯 on 2017/10/10
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct MapModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let zUseTag = "z_use_tag"
    static let zLongitude = "z_longitude"
    static let zAddress = "z_address"
    static let zSaleSow = "z_sale_sow"
    static let z30pig = "z_30pig"
    static let zStaffId = "z_staff_id"
    static let zSalePiglet = "z_sale_piglet"
    static let zOrgNm = "z_org_nm"
    static let zLatitude = "z_latitude"
    static let idKey = "id_key"
    static let zSalePig = "z_sale_pig"
    static let z10pig = "z_10pig"
    static let zSowNum = "z_sow_num"
    static let zRem = "z_rem"
    static let zLogid = "z_logid"
    static let createime = "createime"
  }

  // MARK: Properties
  public var zUseTag: Int?
  public var zLongitude: String?
  public var zAddress: String?
  public var zSaleSow: String?
  public var z30pig: String?
  public var zStaffId: Int?
  public var zSalePiglet: String?
  public var zOrgNm: String?
  public var zLatitude: String?
  public var idKey: Int?
  public var zSalePig: String?
  public var z10pig: String?
  public var zSowNum: Int?
  public var zRem: String?
  public var zLogid: String?
  public var createime: String?

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
    zUseTag = json[SerializationKeys.zUseTag].int
    zLongitude = json[SerializationKeys.zLongitude].string
    zAddress = json[SerializationKeys.zAddress].string
    zSaleSow = json[SerializationKeys.zSaleSow].string
    z30pig = json[SerializationKeys.z30pig].string
    zStaffId = json[SerializationKeys.zStaffId].int
    zSalePiglet = json[SerializationKeys.zSalePiglet].string
    zOrgNm = json[SerializationKeys.zOrgNm].string
    zLatitude = json[SerializationKeys.zLatitude].string
    idKey = json[SerializationKeys.idKey].int
    zSalePig = json[SerializationKeys.zSalePig].string
    z10pig = json[SerializationKeys.z10pig].string
    zSowNum = json[SerializationKeys.zSowNum].int
    zRem = json[SerializationKeys.zRem].string
    zLogid = json[SerializationKeys.zLogid].string
    createime = json[SerializationKeys.createime].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = zUseTag { dictionary[SerializationKeys.zUseTag] = value }
    if let value = zLongitude { dictionary[SerializationKeys.zLongitude] = value }
    if let value = zAddress { dictionary[SerializationKeys.zAddress] = value }
    if let value = zSaleSow { dictionary[SerializationKeys.zSaleSow] = value }
    if let value = z30pig { dictionary[SerializationKeys.z30pig] = value }
    if let value = zStaffId { dictionary[SerializationKeys.zStaffId] = value }
    if let value = zSalePiglet { dictionary[SerializationKeys.zSalePiglet] = value }
    if let value = zOrgNm { dictionary[SerializationKeys.zOrgNm] = value }
    if let value = zLatitude { dictionary[SerializationKeys.zLatitude] = value }
    if let value = idKey { dictionary[SerializationKeys.idKey] = value }
    if let value = zSalePig { dictionary[SerializationKeys.zSalePig] = value }
    if let value = z10pig { dictionary[SerializationKeys.z10pig] = value }
    if let value = zSowNum { dictionary[SerializationKeys.zSowNum] = value }
    if let value = zRem { dictionary[SerializationKeys.zRem] = value }
    if let value = zLogid { dictionary[SerializationKeys.zLogid] = value }
    if let value = createime { dictionary[SerializationKeys.createime] = value }
    return dictionary
  }

}
