import SwiftyJSON

struct Employee {
    var id: Int
    var name: String
    var isManager: Bool = false
    var phone: String
    var email: String
    var title: String
    var department: String
    var managerId: Int?
    var profilePic: String

    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.isManager = json["is_manager"].boolValue
        self.phone = json["phone"].stringValue
        self.email = json["email"].stringValue
        self.title = json["title"].stringValue
        self.department = json["department"].stringValue
        self.managerId = json["manager_id"].int
        self.profilePic = json["profile_pic"].stringValue
    }
}

extension Employee: Equatable {
    static func ==(lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
}
