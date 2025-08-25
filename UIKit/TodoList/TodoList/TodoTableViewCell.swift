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
    titleLabel.attributedText = nil
    priorityView.layer.cornerRadius = 4
    checkButton
      .addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.attributedText = nil
    priorityView.backgroundColor = .clear
    checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
    titleLabel.layoutIfNeeded()
  }

  func configure(with todo: TodoItem) {
    titleLabel.textColor = todo.isCompleted ? .systemGray : .label
    titleLabel.attributedText = attributedText(
      text: todo.title,
      isCompleted: todo.isCompleted
    )

    checkButton
      .setImage(
        UIImage(
          systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle"
        ),
        for: .normal
      )
    checkButton.tintColor = todo.isCompleted ? .systemBlue : .systemGray

    priorityView.backgroundColor = todo.priority.color
  }

  func attributedText(text: String, isCompleted: Bool) -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: text)
    if isCompleted {
      attributeString
        .addAttribute(
          .strikethroughStyle,
          value: NSUnderlineStyle.single.rawValue,
          range: NSRange(location: 0, length: text.count)
        )
    }
    return attributeString
  }

  @objc func toggleComplete() {
    onToggleComplete?()
  }

}
