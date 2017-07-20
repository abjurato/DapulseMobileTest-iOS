//
//  EmployeeCollectionViewControllerCell.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 19/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import UIKit

class EmployeeCollectionViewControllerCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var employeeView: EmployeeView!
    
    internal var employee: Employee?
    
    internal func configure(with employee: Employee) {
        self.employee = employee
        self.employeeView.fill(for: employee)
    }
    
    internal func set(avatar: UIImage?) {
        self.employeeView.set(avatar: avatar)
    }
}
