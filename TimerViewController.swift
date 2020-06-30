

import UIKit
import AVFoundation
import RealmSwift
//音のフレームワーク

class TimerViewController: UIViewController,AVAudioPlayerDelegate {
   
    var timer = Timer()
    var count = 0
    var getTime:Int!
    var audioPlayer: AVAudioPlayer!

    func playSound(name: String) {
        //もしpathがfree.mp3じゃなかったらprint
            guard let path = Bundle.main.path(forResource: "free", ofType: "mp3") else {
                print("音源ファイルが見つかりません")
                return
            }

            do {
                // AVAudioPlayerのインスタンス化　を　try
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))

                // AVAudioPlayerのデリゲートをセット
                audioPlayer.delegate = self
              //オーディオの再生
                    audioPlayer.play()


            } catch {
                //エラーの場合何もしない
            }
        }
//
//
    
   
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var memoButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func StartButton(_ sender: Any) {
     //タイマーが有効なら　何もしない
     if timer.isValid == true {
                return
        //getTimeに値が入っていなかった何もしない
     } else if getTime == nil {
        return
        } else if getTime == 0 {
            return
     } else {
        runTimer()
//        realmSave()
    }
    }
         
   
    
    @IBAction func StopButton(_ sender: Any) {
      
    timer.invalidate()
        print(getTime ?? "this is nil")
        
    }
    
    
    @IBAction func ResetButton(_ sender: Any) {
       
        //getTimeに値が入っていなかった何もしない
        if getTime == nil {
            return
        }
        
        timer.invalidate()
        //リセットした時に経過時間からスタートしないようにするため
        //countを０にする
        count = 0
        
        timerLabel.text = timeString(time: TimeInterval(getTime))
        
    }
   
    
    @IBAction func memoButton(_ sender: Any) {
        //ランダムで表示する
        let segues = ["pushScore","pushScore2","pushScore3"]
        let cou = Int(arc4random_uniform(UInt32(segues.count)))
        let segueName = segues[cou]
        
        
        self.performSegue(withIdentifier: segueName, sender: self)
       
    }

        
    // カウントダウンをする関数
    @objc func updateTimer() -> Int {
       
        count += 1
        //時間　＝　pickerで設定する時間　ー　count
        let remainCount = getTime! - count
       // 00:00:00で表示させる
        timerLabel.text = timeString(time: TimeInterval(remainCount))
        
    
        
//        0秒になったら止まる
        if remainCount == 0 {
            timer.invalidate()
            timerLabel.text = "00:00:00"
            //終了音を鳴らす
            playSound(name: "free")
            
            let realm = try! Realm()
            try! realm.write {
                let m = realm.objects(Meditatioan.self)
                m.last?.mcount += 1
                print(m)
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }

        }
            return remainCount
        
    }
    
    //タイマーを動かす関数
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
    }

    //00:00:00に変える処理
      func timeString(time: TimeInterval) -> String {
          let hour = Int(time) / 3600
          let minutes = Int(time) / 60 % 60
          let second = Int(time) % 60
          
          return String(format: "%02d:%02d:%02d", hour, minutes, second)
      }
    
////    レルムヘ時間の保存
//    func realmSave() {
//        let Realm_time = TimerList()
//        Realm_time.elapsedTime = getTime!
//        Realm_time.memo = getText!
//
//        let realm = try! Realm()
//        try! realm.write() {
//            realm.add(Realm_time)
//            print(Realm.Configuration.defaultConfiguration.fileURL!)
//        }
//    }
    
    override func viewDidLoad() {
           super.viewDidLoad()

        startButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        memoButton.layer.cornerRadius = 10
       }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if getTime == nil {
            timerLabel.text = "00:00:00"
        } else  {
            timerLabel.text = timeString(time: TimeInterval(getTime))
            print(getTime ?? "this is nil")
        }
        
        
    }
  
    func go() {
        let storyboard: UIStoryboard = self.storyboard!
            let score1 = storyboard.instantiateViewController(withIdentifier: "score1") as! UserScoreViewController
            
            self.present(score1, animated: true, completion: nil)
        }
    
    func go2() {
        let storyboard: UIStoryboard = self.storyboard!
            let score2 = storyboard.instantiateViewController(withIdentifier: "score2") as! UserScore2ViewController
            
            self.present(score2, animated: true, completion: nil)
        
    }
    
    func go3() {
        let storyboard: UIStoryboard = self.storyboard!
            let score3 = storyboard.instantiateViewController(withIdentifier: "score3") as! UserScore3ViewController
            
            self.present(score3, animated: true, completion: nil)
    }
    
}



