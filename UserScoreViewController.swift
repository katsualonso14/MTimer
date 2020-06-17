

import UIKit
import RealmSwift

class UserScoreViewController: UIViewController {

    
   
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let me = realm.objects(Meditatioan.self)
        let meditationCount: Int! = me.last?.mcount
        
        countLabel.text = "\(meditationCount ?? 1)" + "回"
    }
}

