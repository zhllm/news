//
//  SQLModel.swift
//  news
//
//  Created by 张杰 on 2020/12/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation

protocol SQLModelProtocol {}


@objcMembers
class SQLModel: NSObject, SQLModelProtocol {
    internal var table = ""
    
    private static var verifed = [String:Bool]()
    
    required override init() {
        super.init()
        // self.table = type(of: self).table
        let verified = SQLModel.verifed[self.table]
        if verified == nil || !verified! {
            let db = SQLiteManager.shareManager().db
            var sql = "DELETE FROM \(table) "
        }
    }
    
    func primaryKey() -> String {
        return "id"
    }
    
    func ignoredKeys() -> [String] {
        return []
    }
    
    static var table:String {
        return "\(classForCoder())"
    }
    
    func unwrap(_ any: Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.count == 0 { return any }
        let (_, some) = mi.children.first!
        return some
    }
    
    private func processMirror(obj: Mirror, results: inout[String: Any]) {
        for (_, attr) in obj.children.enumerated() {
            if let name = attr.label {
                if name == "name" || name == "db" {
                    continue
                }
                if ignoredKeys().contains(name) {
                    name.hasSuffix(".storage")
                    continue
                }
                results[name] = unwrap(attr.value)
            }
        }
    }
    
    
    private func getValues(obj: Mirror?, result: inout[String: Any]) {
        guard let obj = obj else { return }
        
    }
    
}

extension SQLModelProtocol where Self: SQLModel {
    static func rowsFor(sql: String = "") -> [Self] {
        var result = [Self()]
        let temp = self.init()
        let data = temp.value(forKey: <#T##String#>)
        
        return result
    }
}
