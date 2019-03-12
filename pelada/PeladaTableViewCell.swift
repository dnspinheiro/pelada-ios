//
//  PeladaTableViewCell.swift
//  pelada
//
//  Created by Usuário Convidado on 27/02/2019.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import Foundation
import UIKit

class PeladaTableViewCell: UITableViewCell {
    
    // MARK: - Propriedades
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var quantidadeLabel: UILabel!
    @IBOutlet weak var horarioLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
