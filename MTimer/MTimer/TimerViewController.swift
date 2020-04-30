

import UIKit

class TimerViewController: UIViewController {
   
    var timer = Timer()
    var count = 0
    //秒数を保持するキー　文字列の理由？？
    var key = "time"
    var timerRunning = false
    var timerdata:String!
    var getTime = 0
    
    
    @IBOutlet weak var timerLabel: UILabel!
   
    
    
    
    @IBAction func StartButton(_ sender: Any) {
     //タイマーが有効なら　何もしない
     if timer.isValid == true {
                return
            }
        
   
        //タイマーを動かす
        if timerRunning == false {
             runTimer()
        }
    }
         
    @IBAction func StopButton(_ sender: Any) {
      
    timer.invalidate()
        print(getTime)
    }
    
    
    @IBAction func ResetButton(_ sender: Any) {
       
            timer.invalidate()
            
            let set = UserDefaults.standard
            let timevalue = set.integer(forKey: timerdata)
            
            timerLabel.text = "\(timevalue)"
           timerRunning = false
        
        
    }
   
    @IBAction func backButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let picikerboard = storyboard.instantiateViewController(withIdentifier: "pickerboard") as! ViewController
        
        self.present(picikerboard, animated: true, completion: nil)
    }
    
    // カウントダウンをする関数
    @objc func updateTimer() -> Int  {
        //UserDefaultのインスタンス作成
            let set = UserDefaults.standard
       // integer 整数として登録
            let timevalue = set.integer(forKey: timerdata)
            count += 1
        //時間　＝　pickerで設定する時間　ー　count
            let remainCount = timevalue - count
            timerLabel.text = "\(remainCount)"
        
        timerRunning = true
        //0秒になったら止まる
        if remainCount == 0 {
            timer.invalidate()
            timerLabel.text = "0"
        }
            return remainCount
    }
    
    //タイマーを動かす関数
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       // データの登録
//    let set = UserDefaults.standard
//       // 初期値設定（default）regist　登録する
//        set.register(defaults: [key : 10])
        
//        key = timerdata
//        timerLabel.text = String(getTime)
//        print(timerdata ?? "ellor")
//        print(getTime!)
    }

    

}



