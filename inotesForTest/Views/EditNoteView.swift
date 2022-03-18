//
//  EditNoteView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.managedObjectContext) var manObjContext
    @Environment(\.dismiss) var dismiss
    var note: FetchedResults<Notes>.Element
    @State private var name = ""

    var body: some View {
        VStack {
            TextEditor(text: $name)
                .padding(.horizontal)
                .lineSpacing(.leastNormalMagnitude)
                .font(.title2.weight(.thin).monospaced())
                .onAppear {
                    name = note.name!
                }

            Button("Save"){
                DataController().editNote(note: note, name: name, context: manObjContext)
                dismiss()
            }
            .font(.headline)
            .padding()

        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}
