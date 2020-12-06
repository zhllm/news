//
//  ViewController.swift
//  news
//
//  Created by 张杰 on 2020/12/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        createUser()
        // preCompileCreateUser()
        // queryUsers()
        insertData()
    }
    
    func catchErrorAndRollback() {
        if let queue = SQLiteManager.shareManager().dbQueue {
            queue.inTransaction {db, rollback in
                do {
                    for i in 0..<10 {
                        if i == 4 {
                            try db.executeUpdate("INSERT INTO UserXXX (name, age) VALUES (?,?);",  values: ["hangge", i])
                        } else {
                            try db.executeUpdate("INSERT INTO User (name, age) VALUES (?,?);", values: ["hangge", i])
                        }
                    }
                    print("插入成功")
                } catch {
                    print("插入失败, 进行回滚")
                    rollback.pointee = true
                }
            }
        }
    }
    
    func insertData() {
        let db = SQLiteManager.shareManager().db
        if let queue = SQLiteManager.shareManager().dbQueue {
            queue.inTransaction {db, rollback in
                do {
                    for i in 0..<10 {
                        try db.executeUpdate("insert into User (name, age) values (?, ?);", withArgumentsIn: ["Zhllm", i])
                    }
                    print("插入成功")
                } catch {
                    print("插入失败")
                    rollback.pointee = true
                }
            }
        }
    }
    
    func createTable() {
       let sql = "CREATE TABLE IF NOT EXISTS User( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER \n" +
        "); \n"
        
        let db = SQLiteManager.shareManager().db
        if db.open() {
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("创建成功")
            }
        } else {
            print("数据库打开失败\(db.lastErrorMessage())")
        }
        db.close()
    }
    
    func createUser() {
        let sql = "INSERT INTO User (name, age) VALUES('zhllm', 27);"
        let db = SQLiteManager.shareManager().db
        if db.open() {
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("插入成功")
            }
        } else {
            print("插入失败\(db.lastErrorMessage())")
        }
        db.close()
    }
    
    func preCompileCreateUser() {
        let sql = "INSERT INTO User (name, age) VALUES (?, ?);"
        
        let db = SQLiteManager.shareManager().db
        if db.open() {
            if db.executeUpdate(sql, withArgumentsIn: ["zhmllm", 19]) {
                print("插入成功")
            } else {
                print("插入失败")
            }
        } else {
            print("插入失败\(db.lastErrorMessage())")
        }
    }
    
    func queryUsers() {
        let sql = "SELECT * FROM User where id < 10;"
        let db = SQLiteManager.shareManager().db
        if db.open() {
            if let res = db.executeQuery(sql, withArgumentsIn: []) {
                while res.next() {
                    let id = res.int(forColumn: "id")
                    let name = res.string(forColumn: "name")
                    let age = res.int(forColumn: "age")
                    print(id, name ?? "空", age)
                }
            } else {
                print("查询失败")
            }
        } else {
            print("插入失败\(db.lastErrorMessage())")
        }
    }
    
    
}

