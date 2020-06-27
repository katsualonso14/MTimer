
import UIKit
import RealmSwift


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var Item: Results<TimerList>!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        timerTable.reloadData()
    }
    
//    セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {

        return Item.count
    }

//    セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let object = Item[indexPath.row]
        // セルに表示する値を設定する
        cell.textLabel!.text = String(object.elapsedTime)
        cell.textLabel!.text = object.memo
        return cell
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
    }
          
    
}
