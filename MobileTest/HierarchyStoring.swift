//
//  HierarchyStoring.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 20/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import Foundation

protocol HierarchyStoring {
    var manager: Employee? { get }
    var companyService: CompanyService { get }
}
extension HierarchyStoring {
    func hierarchyString() -> String? {
        let managers = sequence(first: self.manager, next: self.manager(of:)).flatMap{ $0 }.reversed()
        
        let hierarchy = managers.reduce("Company") { result, next -> String in
            return result + " → " + next.department
        }
        
        return hierarchy
    }
    
    func manager(of employee: Employee?) -> Employee? {
        guard let managerId = employee?.managerId else { return nil }
        return self.companyService.getEmployee(forId: managerId)
    }
}
