//
//  EmployeeView.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 19/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import UIKit

class EmployeeView: UIView, NibLoadable {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let view = EmployeeView.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatar.layer.cornerRadius = self.avatar.frame.size.height / 2.0
        self.avatar.layer.masksToBounds = true
    }
}

extension EmployeeView {
    internal func fill(`for` employee: Employee) {
        self.name.text = employee.name
        self.position.text = employee.title
    }
    
    internal func set(avatar avatarImage: UIImage?) {
        self.avatar.image = avatarImage
        
    }
}
