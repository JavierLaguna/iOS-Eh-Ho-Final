//
//  UIView+Extensions.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

extension UIView {

    func asCircle() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
