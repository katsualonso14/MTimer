
import UIKit
import RealmSwift

class UserScore3ViewController: UIViewController {

    
    @IBOutlet weak var mLabel3: UILabel!
    @IBOutlet weak var countLabel3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let me = realm.objects(Meditatioan.self)
        let meditationCount: Int! = me.last?.mcount
        
        countLabel3.text = "\(meditationCount ?? 1)" + "回"
    }
   

}
