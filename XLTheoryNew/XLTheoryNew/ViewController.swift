//
//  ViewController.swift
//  XLTheoryNew
//
//  Created by holdtime on 2017/8/15.
//  Copyright © 2017年 www.bthdtm.com 豪德天沐移动事业部. All rights reserved.
//

import UIKit

class XLLLStudyModel: XLSqliteModel {
    
    var name:String!
    var age:NSNumber!
    var school:String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        super.setValue(value, forUndefinedKey: key)
        if key == "age" {
            age = value as! NSNumber
        }
    }

}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = XLLLStudyModel(dictionary: ["name":"zhangsan",
                                                "age":345,
                                                "school":"zhognguo"
            ], tableName: "xlstudy")
    
        let manager = XLSqliteManager()
        manager.config("xlxueche")
        manager.createWith(model)

        manager.insertWith(model)
        manager.insertWith(model)
        manager.insertWith(model)
        manager.insertWith(model)
        manager.insertWith(model)
        let updatemodel = XLLLStudyModel(dictionary: ["name":"wangwu",
                                                     "age":35,
                                                     "school":"ddd"
            ], tableName: "xlstudy")
        
        manager.updateWith(updatemodel, condition: "id=5")
        
        let fmodela = manager.fetchWith(model, condition: "school='zhognguo'", order: nil)

        print(fmodela)
        
        for m in fmodela {
            let xx = XLLLStudyModel(dictionary: m, tableName: model.tableName)
            print(xx)
        }
        
        self.present(XLTheorySingle(), animated: true, completion: nil)
        
    }


}

