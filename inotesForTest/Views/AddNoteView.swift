//
//  AddNoteView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) var manObjContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""

    var body: some View {
        VStack{
            TextEditor(text: $name)
                .padding()
                .lineSpacing(.leastNormalMagnitude)
                .font(.title2.weight(.thin).monospaced())

            Button("Add Note") {
                if name == "" {
                    dismiss()
                } else {
                    DataController().addNote(name: name, date: Date(), context: manObjContext)
                    dismiss()
                }
            }
            .font(.headline)
            .padding()
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
