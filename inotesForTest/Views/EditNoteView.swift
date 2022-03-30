//
//  EditNoteView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI

enum FocusableFieldE: Hashable {
    case text
    //case password
}

struct EditNoteView: View {
    @Environment(\.managedObjectContext) var manObjContext

    @Environment(\.dismiss) var dismiss
    var note: FetchedResults<Notes>.Element
    @State private var name = ""
    @FocusState private var focys: FocusableFieldE?

    var body: some View {
        VStack {
            TextEditor(text: $name)
                .myTextEdit()
                .focused($focys, equals: .text)
                .onAppear {
                    name = note.name!
                }

        }
        .onAppear {
            print("WORK edit!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                focys = .text
            }
        }
        .onDisappear {
            if name == "" {
                name = name
            } else {
            print("DIS whis")
            DataController().editNote(note: note, name: name, context: manObjContext)
            dismiss()
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }

}
