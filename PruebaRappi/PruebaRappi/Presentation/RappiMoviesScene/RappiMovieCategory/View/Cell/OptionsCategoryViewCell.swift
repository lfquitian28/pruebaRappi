//
//  OptionsCategoryViewCell.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import UIKit

class OptionsCategoryViewCell: UITableViewCell {

    @IBOutlet weak var optionCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func createMenu(name: String){
        optionCategory.text = name
    }
    
}
