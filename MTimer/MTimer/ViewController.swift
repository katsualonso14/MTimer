

import UIKit
import RealmSwift

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    let timeList = [[Int](0...24), [Int](0...60), [Int](0...60)]
    var pickerdata:String!
    var timeTotal:Int!
    
//    git確かめ

   
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var listTextView: UITextView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBAction func doneButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let timer = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController
//        let timer = storyboard.instantiateViewController(withIdentifier: "timer")
////
        timer.getTime = timeTotal
    
        navigationController?.pushViewController(timer, animated: true)
//        self.present(timer, animated: true, completion: nil)r
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let realm = try! Realm()

        
        try! realm.write {
            let times = [TimerList(value: ["elapsedTime": timeTotal ?? 0,"memo": listTextView.text!])]
            realm.add(times)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timePicker.dataSource = self
        timePicker.delegate = self
       
        listTextView.layer.borderColor = UIColor.gray.cgColor
        listTextView.layer.borderWidth = 1.0
        listTextView.layer.cornerRadius = 10.0
        
        doneButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        
        let hStr = UILabel()
        hStr.text = "時間"
        hStr.sizeToFit()
        hStr.frame = CGRect(x: timePicker.bounds.width/4 - hStr.bounds.width/2,
                            y: timePicker.bounds.height/2 - (hStr.bounds.height/2),
                            width: hStr.bounds.width, height: hStr.bounds.height)
        timePicker.addSubview(hStr)
        
        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
//        let ti = timePicker.bounds.width/2 - mStr.bounds.width/2
        mStr.frame = CGRect(x: 225,
                            y: timePicker.bounds.height/2 - (mStr.bounds.height/2),
                            width: mStr.bounds.width, height: mStr.bounds.height)
        timePicker.addSubview(mStr)
        
        
        //「秒」のラベルを追加
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
//        let t = timePicker.bounds.width * 3/4 - sStr.bounds.width/2
        sStr.frame = CGRect(x: 335,
                            y: timePicker.bounds.height/2 - (sStr.bounds.height/2),
                            width: sStr.bounds.width, height: sStr.bounds.height)
        
        timePicker.addSubview(sStr)
        
        let defaults = UserDefaults.standard
        //        初回起動時のみ　mcountを追加
        if defaults.bool(forKey: "firstLaunch") {

            let realm = try! Realm()
            let m = Meditatioan()
            m.mcount = 1

            try! realm.write(){
                realm.add(m)
            }
            //            2回目以降はキーをfalseに
            defaults.set(false, forKey: "firstLaunch")
        }
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
        timeTotal = timeList[0][timePicker.selectedRow(inComponent: 0)] * 60 * 60 + timeList[0][timePicker.selectedRow(inComponent: 1)] * 60 + timeList[0][timePicker.selectedRow(inComponent: 2)]

    }
    
    func timeString(time: TimeInterval) -> String {
             let hour = Int(time) / 3600
             let minutes = Int(time) / 60 % 60
             let second = Int(time) % 60
             
             return String(format: "%02d:%02d:%02d", hour, minutes, second)
    
         }
    
}


