//
//  NibLoadable.swift
//  MobileTest
//
//  Created by Anatoly Rosencrantz on 19/07/2017.
//  Copyright © 2017 dapulse. All rights reserved.
//

import UIKit

protocol NibLoadable {}
extension NibLoadable where Self: UIView {
    internal static var nib: UINib {
        return .init(nibName:  String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
}
