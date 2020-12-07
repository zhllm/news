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
        self.table = type(of: self).table
        let verified = SQLModel.verifed[self.table]
        if verified == nil || !verified! {
            let db = SQLiteManager.shareManager().db
            var sql = "CREATE TABLE IF NOT EXISTS \(table) ("
            let cols = values()
            var first = true
            for col in cols {
                if first {
                    first = false
                    sql += getColumnSql(column: col)
                } else {
                    sql += ", " + getColumnSql(column: col)
                }
            }
            sql += ");"
            if db.open() {
                if db.executeUpdate(sql, withArgumentsIn: []) {
                    SQLModel.verifed[table] = true
                    print("\(table) 表自定创建")
                }
            }
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
    
    func getSql(data: [String: Any], forInsert: Bool = true) -> (String, [Any]?) {
        var sql = ""
        var pramas: [Any]? = nil
        if forInsert {
            sql = "INSERT INTO  \(table) ("
        } else {
            sql = "UPDATE \(table) set"
        }
        var pkey = primaryKey()
        var wsql = ""
        var rid:Any?
        var first = true
        for (key, val) in data {
            if pkey == key {
                if forInsert {
                    if val is Int && (val as! Int) == -1 {
                        continue
                    }
                } else {
                    wsql += " WHERE " + key + " = ?"
                    rid = val
                    continue
                }
            }
            if first && pramas == nil {
                pramas = [AnyObject]()
            }
            if forInsert {
                sql += first ? "\(key)" : ", \(key)"
                wsql += first ? "VALUES (?" : ", ?"
                pramas!.append(val)
            }
            first = false
        }
        if forInsert {
            sql += ") " + wsql + ");"
        } else if pramas != nil && !wsql.isEmpty {
            sql += wsql
            pramas?.append(rid!)
        }
        return (sql, pramas)
        
    }
    
    func getColumnSql(column: (key: String, value: Any)) -> String {
        let key = column.key
        let val = column.value
        var sql = "'\(key)' "
        if val is Int {
            sql += "INTEGER"
            if key == primaryKey() {
                sql += " PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE"
            } else {
                sql += " DEFAULT \(val)"
            }
        } else {
            if val is Float || val is Double {
                sql += "REAL DEFAULT \(val)"
            } else if val is Bool {
                sql += "BOOLEAN DEFAULT " + ((val as! Bool) ? "0" : "1")
            } else if val is Date {
                sql += "Date"
            } else if val is NSData {
                sql += "BLOB"
            } else {
                sql += "TEXT"
            }
            
            if key == primaryKey() {
                sql += " PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE"
            }
        }
        return sql
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
    
    internal func values() -> [String: Any] {
        var res = [String: Any]()
        let obj = Mirror(reflecting: self)
        processMirror(obj: obj, results: &res)
        getValues(obj: obj.superclassMirror, results: &res)
        return res
    }
    
    private func processMirror(obj: Mirror, results: inout[String: Any]) {
        for (_, attr) in obj.children.enumerated() {
            if let name = attr.label {
                if name == "name" || name == "db" {
                    continue
                }
                if ignoredKeys().contains(name) {
                    _ = name.hasSuffix(".storage")
                    continue
                }
                results[name] = unwrap(attr.value)
            }
        }
    }
    
    
    private func getValues(obj: Mirror?, results: inout[String: Any]) {
        guard let obj = obj else { return }
        processMirror(obj: obj, results: &results)
        getValues(obj: obj.superclassMirror, results: &results)
    }
    
}

extension SQLModelProtocol where Self: SQLModel {
    static func rowsFor(sql: String = "") -> [Self] {
        var result = [Self()]
        let temp = self.init()
        let data = temp.values()
        let db = SQLiteManager.shareManager().db
        let fsql = sql.isEmpty ? "SELECT * FROM \(table)" : sql
        if let res = db.executeQuery(fsql, withArgumentsIn: []) {
            while res.next() {
                let t = self.init()
                for (key, _) in data {
                    if let val = res.object(forColumn: key) {
                        t.setValue(val, forKey: key)
                    }
                }
                result.append(t)
            }
        } else {
            print("查询失败")
        }
        
        return result
    }
    static func rows(
        filter: String = "", order: String = "", limit: Int = 0
    ) -> [Self] {
        var sql = "SELECT * FROM \(table)"
        if !filter.isEmpty {
            sql += " WHERE \(filter)"
        }
        if !order.isEmpty {
            sql += " ORDER BY \(order)"
        }
        if limit > 0 {
            sql += " limit 0, \(limit)"
        }
        return self.rowsFor(sql: sql)
    }
}
