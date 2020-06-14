

import UIKit
import AVFoundation
import RealmSwift
//音のフレームワーク

class TimerViewController: UIViewController,AVAudioPlayerDelegate {
   
    var timer = Timer()
    var count = 0
    var getTime:Int!
    var audioPlayer: AVAudioPlayer!
    //インスタンスの宣言

    
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
        //動かすインスタンス
        runTimer()
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
   
    @IBAction func backButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let picikerboard = storyboard.instantiateViewController(withIdentifier: "pickerboard") as! ViewController
        
        self.present(picikerboard, animated: true, completion: nil)
    }
    
    @IBAction func memoButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
               let memo1 = storyboard.instantiateViewController(withIdentifier: "memo1") as! MemoViewController
               
        
               self.present(memo1, animated: true, completion: nil)
    }
    
    @IBAction func memo2Button(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let memo2 = storyboard.instantiateViewController(withIdentifier: "memo2") as! Memo2ViewController
        
        self.present(memo2, animated: true, completion: nil)
    }
    
    @IBAction func memo3Button(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let memo3 = storyboard.instantiateViewController(withIdentifier: "memo3") as! Memo3ViewController
        
        self.present(memo3, animated: true, completion: nil)
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
    
    
    override func viewDidLoad() {
           super.viewDidLoad()

          
       }

    override func viewDidAppear(_ animated: Bool) {
        if getTime == nil {
            timerLabel.text = "00:00:00"
        } else  {
            timerLabel.text = timeString(time: TimeInterval(getTime))
            print(getTime ?? "this is nil")
        }
        
        
    }
  
    
}



