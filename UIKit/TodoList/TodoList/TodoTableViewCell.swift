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

  var onToggleComplete: (() -> Void)?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    priorityView.layer.cornerRadius = 4
    checkButton
      .addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
  }

  func configure(with todo: TodoItem) {
    titleLabel.text = todo.title
    titleLabel.textColor = todo.isCompleted ? .systemGray : .label
    titleLabel.attributedText = todo.isCompleted ? strikeThrough(
      text: todo.title
    ) : NSAttributedString(string: todo.title)
  }

  func strikeThrough(text: String) -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: text)
    attributeString
      .addAttribute(
        .strikethroughStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: NSRange(location: 0, length: text.count)
      )
    return attributeString
  }

  @objc func toggleComplete() {
    onToggleComplete?()
  }
}
