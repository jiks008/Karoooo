//
//  UserListTableViewCell.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    class var identifier: String { return String(describing: self) }
    
    var cellViewModel: UserCellViewModel? {
        didSet {
            lblName.text = cellViewModel?.name
            lblPhone.text = cellViewModel?.phone
            lblEmail.text = cellViewModel?.email
            lblAddress.text = cellViewModel?.address
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            
        lblName.text = nil
        lblPhone.text = nil
        lblEmail.text = nil
        lblAddress.text = nil
    }
}
