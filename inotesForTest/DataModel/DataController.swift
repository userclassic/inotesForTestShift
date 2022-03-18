//
//  DataController.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let conteiner = NSPersistentContainer(name: "NoteModel")

    init() {
        conteiner.loadPersistentStores { desc, error in
            if let error = error {
                print("Fail to load Data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context:NSManagedObjectContext) {
        do {
            try context.save()
            print("Data SAVE!")
        } catch {
            print("NOT save the Data")
        }
    }

    func addNote(name:String, date:Date, context:NSManagedObjectContext) {

        let note = Notes (context: context)
        note.id = UUID()
        note.date = Date()
        note.name = name

        save(context: context)
    }

    func editNote (note:Notes, name:String, context:NSManagedObjectContext) {
        note.date = Date()
        note.name = name

        save(context: context)
    }
}
