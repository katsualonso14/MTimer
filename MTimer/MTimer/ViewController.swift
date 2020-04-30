//
//  ViewController.swift
//  MTimer
//
//  Created by 玉井　勝也 on 2020/04/07.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    let timeList = [[Int](0...24), [Int](0...60), [Int](0...60)]
    var pickerdata:String!
    var timeTotal:Int!
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBAction func doneButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let timer = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController
        
//
        timeTotal = timer.getTime
    
        self.present(timer, animated: true, completion: nil)
    }
    
    @IBAction func button(_ sender: Any) {
//        total()
        print(timeTotal ?? "this is nil")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timePicker.dataSource = self
        timePicker.delegate = self
       
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeList.count
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList[component].count
       }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeList[component][row])
           
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        total()
        print(timeTotal ?? "this is nil")
        
        }
    
//    pickerの数字をたすメソッド
    func total() {
        timeTotal = timeList[0][timePicker.selectedRow(inComponent: 0)] + timeList[0][timePicker.selectedRow(inComponent: 1)] + timeList[0][timePicker.selectedRow(inComponent: 2)]

    }
}

