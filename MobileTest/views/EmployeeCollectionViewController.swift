//
//  EmployeeCollectionViewController.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 19/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import UIKit

protocol EmployeesSource: class {
    var employees: [Employee] { get }
    var companyService: CompanyService { get }
    var collectionView: UICollectionView? { get set }
    
    func selected(at index: Int)
}

class EmployeeCollectionViewController: UICollectionViewController {
    weak var dataSource: EmployeesSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(EmployeeCollectionViewControllerCell.nib, forCellWithReuseIdentifier: String(describing: EmployeeCollectionViewControllerCell.self))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.employees.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewControllerCell.self), for: indexPath) as? EmployeeCollectionViewControllerCell else
        {
            fatalError("Failed to dequeue cell")
        }
        
        let employee = dataSource.employees[indexPath.row]
    
        cell.configure(with: employee)
        dataSource.companyService.getAvatar(from: URL(string: employee.profilePic)!) { avatar in
            guard cell.employee == employee else {
                return // for case when avatar was downloaded after cell already is reused
            }
            
            cell.set(avatar: avatar)
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataSource.selected(at: indexPath.row)
    }
}
