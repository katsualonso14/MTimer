

import Foundation
import RealmSwift


class Meditatioan: Object {
    
    @objc dynamic var mcount = 1
}
class TimerList: Object {
    
    @objc dynamic var elapsedTime = 1
    @objc dynamic var memo = ""
}
