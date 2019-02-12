//
//  CustomCell.swift
//  GPACalculator 2.0
//
//  Created by Alan Bui on 1/3/19.
//  Copyright © 2019 AlanBui. All rights reserved.
//

import UIKit
class CustomCell: UITableViewCell, UITextFieldDelegate{
   
    @IBOutlet weak var letterGrade: UITextField!
    @IBOutlet weak var Credit: UITextField!
    
   
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
