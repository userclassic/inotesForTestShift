//
//  AddNoteView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI

enum FocusableField: Hashable {
    case text
    case password
}

struct AddNoteView: View {
    @Environment(\.managedObjectContext) var manObjContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @FocusState private var focys: FocusableField?


    var body: some View {
        VStack {
            TextEditor(text: $name)
                .myTextEdit()
                .focused($focys, equals: .text)
                

            Button("Done") {
                if name == "" {
                    dismiss()
                } else {
                    DataController().addNote(name: name, date: Date(), context: manObjContext)
                    dismiss()
                }
            }
            .myRightButton()
            .buttonStyle(.bordered)
            .tint(.accentColor)
        }
        .onAppear {
            print("WORK Add!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                focys = .text
            }
        }
        .toolbar {
            ToolbarItem {
                Button ("Donne") {
                    print("YYYEs")
                }
            }
        }

    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
