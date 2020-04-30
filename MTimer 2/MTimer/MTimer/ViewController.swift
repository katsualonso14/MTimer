//
//  ViewController.swift
//  MTimer
//
//  Created by 玉井　勝也 on 2020/04/07.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBAction func doneButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let timer = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController
        self.present(timer, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }



}

