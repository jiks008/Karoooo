//
//  UserDetailsTableViewCell.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: UserDetailsCellViewModel? {
        didSet {
            lblTitle.text = cellViewModel?.title
            lblDetails.text = cellViewModel?.details
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblTitle.text = nil
        lblDetails.text = nil
    }
}
