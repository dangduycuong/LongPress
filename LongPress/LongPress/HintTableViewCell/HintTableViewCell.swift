//
//  HintTableViewCell.swift
//  LongPress
//
//  Created by Dang Duy Cuong on 3/9/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

class HintTableViewCell: BaseTableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var categoryTextView: UITextView!
    
    var data = Hints()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData() {
        
        categoryTextView.text = data.food?.category
    }
    
}
