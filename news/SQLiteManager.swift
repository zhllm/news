//
//  SQLiteManager.swift
//  news
//
//  Created by 张杰 on 2020/12/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import FMDB

class SQLiteManager: NSObject {
    private static let manager: SQLiteManager = SQLiteManager()
    
    // 相当于类的静态方法
    class func shareManager() -> SQLiteManager {
        return manager
    }
    
    private let dbName = "test.db"
    
    
    lazy var dbURL: URL = {
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dbName)
        print("数据库地址: ", fileURL)
        return fileURL
    }()
    
    lazy var db: FMDatabase = {
        let database = FMDatabase(url: dbURL)
        return database
    }()
    
    lazy var dbQueue: FMDatabaseQueue? = {
        let databaseQueue = FMDatabaseQueue(url: dbURL)
        return databaseQueue
    }()
    
}
