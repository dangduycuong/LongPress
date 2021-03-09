//
//  Storyboard.swift
//  LongPress
//
//  Created by Dang Duy Cuong on 3/9/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

struct Storyboard {
    
}

extension Storyboard {
    
    struct Main {
        static let manager = UIStoryboard(name: "Main", bundle: nil)
        
        static func showFoodViewController() -> ShowFoodViewController {
            return manager.instantiateViewController(withIdentifier: "ShowFoodViewController") as! ShowFoodViewController
        }
        
    }
}
