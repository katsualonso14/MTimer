

import UIKit
import RealmSwift

class UserScore2ViewController: UIViewController {

    @IBOutlet weak var mLabel2: UILabel!
    
    @IBOutlet weak var countLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let me = realm.objects(Meditatioan.self)
        let meditationCount: Int! = me.last?.mcount
        
        countLabel2.text = "\(meditationCount ?? 1)" + "回"
    }
}

