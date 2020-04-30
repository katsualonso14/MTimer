

import UIKit

class TimerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
      var timer = Timer()
      var count = 0
    let timeList = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    let timeList2 = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
//   let timeList = [[Int](0...24), [Int](0...60), [Int](0...60)]
    
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    @IBAction func StartButton(_ sender: Any) {
         timer.invalidate()
        //すべての秒の計算　１時間なら　1 * 60 * 60 1分なら　1 * 60
//        count = timeList[0][timerPicker.selectedRow(inComponent: 0)] * 60 * 60  +
//            timeList[0][timerPicker.selectedRow(inComponent: 1)] * 60 +
//            timeList[0][timerPicker.selectedRow(inComponent: 2)]
//
         
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(self.countDown), userInfo:nil, repeats:true)
    }
         
    @IBAction func StopButton(_ sender: Any) {
        timer.invalidate()
       
    }
    
    @IBAction func ResetButton(_ sender: Any) {
        timer.invalidate()
        
    }
    
    @objc func countDown(){
        
         count -= 1
         if count > 0 {
             timerLabel.text = "\(count)"
         } else {
            timerLabel.text = "0"
             timer.invalidate()
            //この時アラームを鳴らす
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerPicker.dataSource = self
        timerPicker.delegate = self
    }
    // pickerの列
 func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    // pickerのドラムロールの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return timeList.count
        } else if component == 1 {
           return timeList2.count
        }
        return timeList2.count
//        return timeList[component].count
    }

    
 //   ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return timeList[row]
        }
        return timeList2[row]
    }

// 表示する場所を指定
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerLabel.text = timeList[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//           timerPicker.bounds.width * 1/4
//       }
////
////
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        timerLabel.text = String(timeList[component][row])
//        return timerLabel
//    }
}



