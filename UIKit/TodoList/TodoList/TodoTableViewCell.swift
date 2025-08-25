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
    titleLabel.text = nil
    priorityView.layer.cornerRadius = 4
    checkButton
      .addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    print("취소선이 이상해요 \(titleLabel.attributedText.debugDescription)")
    titleLabel.attributedText = nil
    titleLabel.text = nil
    priorityView.backgroundColor = .clear
    checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
  }

  func configure(with todo: TodoItem) {
    print("\(todo.title): \(todo.isCompleted)")
    titleLabel.textColor = todo.isCompleted ? .systemGray : .label
    titleLabel.attributedText = attributedText(
      text: todo.title,
      isCompleted: todo.isCompleted
    )
    titleLabel.text = todo.title

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
    } else {
      print("여기로 오세요 \(text)")
      attributeString
        .removeAttribute(
          .strikethroughStyle,
          range: NSRange(location: 0, length: text.count)
        )
    }
    print("\(attributeString.debugDescription)")
    return attributeString
  }

  @objc func toggleComplete() {
    onToggleComplete?()
  }

}
