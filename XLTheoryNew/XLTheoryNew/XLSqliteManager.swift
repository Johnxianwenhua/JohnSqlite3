//
//  XLSqliteManager.swift
//  XLTheoryNew
//
//  Created by holdtime on 2017/8/15.
//  Copyright © 2017年 www.bthdtm.com 豪德天沐移动事业部. All rights reserved.
//

import UIKit

//一个model 关联一个表
class XLSqliteModel:NSObject {
    
    var pid:String?
    var tableName:String!
    
    init(dictionary:[String:Any], tableName name:String) {
        super.init()
        tableName = name
        setValuesForKeys(dictionary)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        if key == "id" {
            pid = value as? String
        }
    }

}

//Model  所有数据库中包含的Model 直接继承该Model 然后做数据映射

class XLSqliteManager {
    
    let optionstring:String! = "sss"
    let optionint:Int! = 12

    
    private var db :XLSqliteService?
    
    public func close(){
        db?.close()
    }
    
    //数据插入
    public func insertWith(_ model:XLSqliteModel)->Bool{
        
        let mirror:Mirror = Mirror(reflecting: model)
        
        var rowInfo:[String:String] = [:]
                
        for m in mirror.children {
            
            let vMirror = Mirror(reflecting: m.value)
            
            if(vMirror.subjectType == type(of: optionstring)){
                rowInfo[m.label!] = "'\(m.value)'"
            }else{
                rowInfo[m.label!] = "\(m.value)"
            }

        }
        
        return insert(tableName: model.tableName, rowInfo: rowInfo)
    }
    
    //数据更新
    public func updateWith(_ model:XLSqliteModel, condition:String)->Bool{
        
        let mirror:Mirror = Mirror(reflecting: model)
        
        var rowInfo:[String:String] = [:]
        
        for m in mirror.children {
        
            let vMirror = Mirror(reflecting: m.value)
            
            if(vMirror.subjectType == type(of: optionstring)){
                rowInfo[m.label!] = "'\(m.value)'"
            }else{
                rowInfo[m.label!] = "\(m.value)"
            }
        }
        return update(tableName: model.tableName, cond:condition, rowInfo: rowInfo)
    }
    //数据检索
    public func fetchWith(_ model:XLSqliteModel, condition:String, order: String?)->[[String:String]]{
    
        let statement = fetch(tableName: model.tableName, cond: condition, order: order)

        var rowModel:[[String:String]] = []
        
        while sqlite3_step(statement) == SQLITE_ROW{
            
            var rowInfo:[String:String] = [:]

            let mirror:Mirror = Mirror(reflecting: model)
            
            var count = 0
            for m in mirror.children {
            
                rowInfo[m.label!] = String(cString: sqlite3_column_text(statement, Int32(count)))
                count = count + 1
            }
            
            rowModel.append(rowInfo)
            print("Successfully fetch")

        }
        sqlite3_finalize(statement)
        return rowModel
    }
    //表 创建
    public func createWith(_ model:XLSqliteModel)->Bool{
        
        let mirror:Mirror = Mirror(reflecting: model)
        
        var rowInfo:[String] = []
        
        rowInfo.append("id integer primary key autoincrement")
        
        for m in mirror.children {
            
            let vMirror = Mirror(reflecting: m.value)
        
            if(vMirror.subjectType == type(of: optionstring)){
                rowInfo.append(m.label!+" text")
            }
            
            if(vMirror.subjectType == type(of: optionint)){
                rowInfo.append(m.label!+" integer")
            }
            
        }
       return create(tableName: model.tableName, columnsInfo: rowInfo)
    }

    //加载默认数据库
    init() {
       config()
    }
    
    public func config(_ dbname:String = "xlxueche"){
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let sqlitePath = urls[urls.count-1].absoluteString + dbname + ".db"
        db = XLSqliteService(path: sqlitePath)
        
    }
    
    private func create(tableName:String, columnsInfo:[String])->Bool{
    
        if let service = db {
            return service.createTable(tableName, columnsInfo: columnsInfo)
        }else{
            return false
        }
    
    }
    
    private func insert(tableName:String, rowInfo:[String:String])->Bool{
        
        if let service = db {
            return service.insert(tableName, rowInfo: rowInfo)
        }else{
            return false
        }
    }
    
    private func fetch(tableName: String, cond: String?, order: String?)->OpaquePointer?{
    
        if let service = db {
            let statement = service.fetch(tableName, cond: cond, order: order)
            return statement
        }else{
            return nil
        }
    }
    
    private func update(tableName: String, cond: String?, rowInfo: [String : String])->Bool{
        
        if let service = db {
            return service.update(tableName, cond: cond, rowInfo: rowInfo)
        }else{
            return false
        }
    }
    
    private func delete(tableName: String, cond: String?)->Bool{
        
        if let service = db {
            return service.delete(tableName, cond: cond)
        }else{
            return false
        }
    }
}
