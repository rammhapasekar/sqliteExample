//
//  BounceableButton.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 12/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import UIKit

class BounceableButton: UIButton {

    //MARK:
    //MARK: touchesBegan
    /*
     This method will add little animation on our UIButton, when we click UIButton  it will just tranfrom little bit and will come to it's original size
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}
