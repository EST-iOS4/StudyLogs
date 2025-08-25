//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priorityView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
