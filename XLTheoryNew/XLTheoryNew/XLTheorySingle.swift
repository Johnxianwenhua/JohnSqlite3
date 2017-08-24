//
//  XLTheorySingle.swift
//  XLXC_BB
//
//  Created by holdtime on 2017/8/23.
//  Copyright © 2017年 holdtime. All rights reserved.
//

import UIKit

class XLTheorySingle: UIViewController {

    @IBOutlet weak var tImageRemove: UIImageView!
    
    @IBOutlet weak var tCButtonRemove: UIStackView!
    @IBOutlet weak var tCLineRemove: UILabel!
    @IBOutlet weak var tDButtonRemove: UIStackView!
    @IBOutlet weak var tAnswerTitleRemove: UIView!
    @IBOutlet weak var tAnswerDetialRemove: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func tAButtonAction(_ sender: Any) {
        tImageRemove.isHidden = !tImageRemove.isHidden
    }
    
    @IBAction func tBButtonAction(_ sender: Any) {
        tCButtonRemove.isHidden = !tCButtonRemove.isHidden
        tCLineRemove.isHidden = !tCLineRemove.isHidden
        tDButtonRemove.isHidden = !tDButtonRemove.isHidden
    }

    @IBAction func tCButtonAction(_ sender: Any) {
        tAnswerTitleRemove.isHidden = !tAnswerTitleRemove.isHidden

    }
    
    @IBAction func tDButtonAction(_ sender: Any) {
        tAnswerDetialRemove.isHidden = !tAnswerDetialRemove.isHidden

    }

    
    

}
