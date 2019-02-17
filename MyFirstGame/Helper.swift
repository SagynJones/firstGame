//
//  Helper.swift
//  MyFirstGame
//
//  Created by Сагын Акжолов on 17.02.2019.
//  Copyright © 2019 Сагын Акжолов. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {
    
    func randomBetweenTwoNumbers(firstNUmber: CGFloat, secondNumber: CGFloat) -> CGFloat{
        return CGFloat(arc4random())/CGFloat(UINT32_MAX) * abs(firstNUmber - secondNumber) + min(firstNUmber, secondNumber)
    }
}
