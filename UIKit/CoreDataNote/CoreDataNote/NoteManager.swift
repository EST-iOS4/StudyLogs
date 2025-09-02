//
//  NoteManager.swift
//  CoreDataNote
//
//  Created by Jungman Bae on 8/29/25.
//

import UIKit
import CoreData

enum NoteError: Error {
  case noTitle
  case noContent
}

class NoteManager {
  let context = CoreDataStack.shared.viewContext

  func createNote(title: String, content: String, image: UIImage?) -> Note {
    let note = Note(context: context)
    note.id = UUID()
    note.title = title
    note.content = content
    note.createdAt = Date()
    note.modifiedAt = Date()
    note.isFavorite = false

    if let image = image,
       let imageData = image.jpegData(compressionQuality: 0.8) {
      note.imageData = imageData
    }
    CoreDataStack.shared.save()
    return note
  }

  func updateNote(note: Note, title: String, content: String, image: UIImage?) throws {
    if title.isEmpty {
      throw NoteError.noTitle
    }
    if content.isEmpty {
      throw NoteError.noContent
    }

    note.title = title
    note.content = content
    if let image = image,
       let imageData = image.jpegData(compressionQuality: 0.8) {
      note.imageData = imageData
    }
    CoreDataStack.shared.save()
  }

  func searchNotes(keyword: String) -> [Note] {
    let request: NSFetchRequest<Note> = Note.fetchRequest()

    if !keyword.isEmpty {
      request.predicate = NSPredicate(
        format: "title CONTAINS[cd] %@",
        keyword, keyword)
    }

    request.sortDescriptors = [
      NSSortDescriptor(key: "modifiedAt", ascending: false)
    ]

    do {
      return try context.fetch(request)
    } catch {
      print("error: \(error)")
      return []
    }
  }
}
