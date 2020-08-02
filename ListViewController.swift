
import UIKit
import RealmSwift


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var Item: Results<TimerList>!
    var elapsed_time = 1
    
    
   
    @IBOutlet weak var timerTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let realm = try Realm()
             Item = realm.objects(TimerList.self)
            timerTable.reloadData()
        }catch{

        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.timerTable.reloadData()
        timerTable.dataSource = self
        timerTable.delegate = self
    }
    
// 
//    セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {

        return Item.count
    }

//    セルの中身/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
         let cell = timerTable.dequeueReusableCell(withIdentifier: "TableViewCell") as! TabelViewCell
            
        
        let object = Item[indexPath.row]
       
        
        cell.memoLabel!.text = object.memo
        cell.timeLabel!.text = timeString(time: TimeInterval(object.elapsedTime))
        
        elapsed_time = object.elapsedTime
        
        return cell
   
    }
   
    
    func timeString(time: TimeInterval) -> String {
             let hour = Int(time) / 3600
             let minutes = Int(time) / 60 % 60
             let second = Int(time) % 60
             
             return String(format: "%02d:%02d:%02d", hour, minutes, second)
         }
    
    
//   セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        do{
            let realm = try Realm()
            try realm.write {
                realm.delete(self.Item[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }catch{
        }
        tableView.reloadData()
    }
//          タップ処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        画面遷移
     let storyboard: UIStoryboard = self.storyboard!
            let timer = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController
    
//        タップされた時間を渡す
        let object = Item[indexPath.row]
        timer.getTime = object.elapsedTime
            
        
            navigationController?.pushViewController(timer, animated: true)
        
       }
    
    func configure(data: [Int]) {
      // データ更新処理など実行 
        self.timerTable.reloadData()

      DispatchQueue.main.async {
        let indexPath = IndexPath(row: 0, section: 0)
        self.timerTable.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
      }
    }

}
