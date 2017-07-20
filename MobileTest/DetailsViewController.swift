//
//  DetailsViewController.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 20/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, HierarchyStoring {
    let companyService = CompanyService.main
    var employee: Employee!
    var manager: Employee? {
        return self.manager(of: self.employee)
    }
    
    @IBOutlet weak var employeeView: EmployeeView!
    
    // looks like UX supposed them to be clickable in future
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var email: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.employeeView.fill(for: employee)
        companyService.getAvatar(from: URL(string: employee.profilePic)!, into: self.employeeView.set(avatar:))
        
        self.phone.setTitle(self.employee.phone, for: .normal)
        self.email.setTitle(self.employee.email, for: .normal)
        
        self.navigationItem.title = self.hierarchyString()
    }
}
