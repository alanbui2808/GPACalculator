//
//  ViewController.swift
//  GPACalculator 2.0
//
//  Created by Alan Bui on 1/3/19.
//  Copyright © 2019 AlanBui. All rights reserved.
//

import UIKit
struct input{
    var credit:Double
    var gradeofLetter:Double
}
struct Lettergrade{
    var letter:String
    var grade:Double
}

class TableViewController : UITableViewController, UITextFieldDelegate, UIPickerViewDelegate {
    var lettergrade = [Lettergrade]()
    var inputRead = [input]()
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var result: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lettergrade.append(Lettergrade(letter: "A", grade: 4.00))
        lettergrade.append(Lettergrade(letter: "A-", grade: 3.70))
        lettergrade.append(Lettergrade(letter: "B+", grade: 3.30))
        lettergrade.append(Lettergrade(letter: "B", grade: 3.00))
        lettergrade.append(Lettergrade(letter: "B-", grade: 2.70))
        lettergrade.append(Lettergrade(letter: "C+", grade: 2.30))
        lettergrade.append(Lettergrade(letter: "C", grade: 2.00))
        lettergrade.append(Lettergrade(letter: "C-", grade: 1.70))
        lettergrade.append(Lettergrade(letter: "D+", grade: 1.30))
        lettergrade.append(Lettergrade(letter: "D", grade: 1.00))
        lettergrade.append(Lettergrade(letter: "F", grade: 0.00))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        customCell.letterGrade.delegate = self
        customCell.Credit.delegate = self
        customCell.letterGrade.tag = indexPath.row
        customCell.Credit.tag = indexPath.row
        
        return customCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputRead.count
    }
    
    @IBAction func addButton(_ sender: Any) {
        inputRead.append(input(credit: 0.0, gradeofLetter: 0.0))
        table.beginUpdates()
        table.insertRows(at: [IndexPath(row: inputRead.count-1, section: 0)], with: .automatic)
        table.endUpdates()
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let row = textField.tag
        
        let indexPath = IndexPath(row: textField.tag, section: 0)
        if let customCell = self.table.cellForRow(at: indexPath) as? CustomCell{
            
            if(textField.isEqual(customCell.letterGrade)){
                inputRead[row].gradeofLetter = customCell.letterGrade.text!.isEmpty ? 0.0:letterToGrade(String(customCell.letterGrade.text!))
            }else if (textField.isEqual(customCell.Credit)){
                inputRead[row].credit = customCell.Credit.text!.isEmpty ? 0.0:Double(customCell.Credit.text!)!
            }
           
        }
    
    }
    
    func letterToGrade(_ letterGrade:String)->Double{
        var grade:Double = -1
        for index in 0...(lettergrade.count-1){
            if(letterGrade == lettergrade[index].letter){
                grade = lettergrade[index].grade
            }
        }
        return grade
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        if(inputRead.count == 0 ){
            return
        }
        
        var totalGrade:Double = 0
        var totalCredit:Double = 0
        var tempResult:Double = 0
        
        for index in 0...(inputRead.count-1){
            if( (inputRead[index].credit == 0 && inputRead[index].gradeofLetter == 0) ||
                (inputRead[index].credit > 0 && inputRead[index].gradeofLetter > 0)){
            
                totalGrade  = totalGrade + inputRead[index].credit * inputRead[index].gradeofLetter
                totalCredit = totalCredit + inputRead[index].credit
            }else{
                result.text = "Invalid Input. Please Try Again!"
                return // handle the case when without grade or credit
            }
        }
        if(totalCredit == 0){
            result.text = "Invalid Input. Please Try Again!"
            return
        }
        
        tempResult = totalGrade/totalCredit
        
        if(tempResult >= 3.30 && tempResult <= 4.00){
            result.text = "Your GPA is " + String(round(tempResult*100)/100) + ". Well Done!"
        }else{
            result.text = "Your GPA is " + String(round(tempResult*100)/100) + ". Keep Trying!"
        }
    }
    
}

