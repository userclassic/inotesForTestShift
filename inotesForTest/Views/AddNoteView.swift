//
//  AddNoteView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI
// добавляем новую заментку
// доработать, убрать перечисление
enum FocusableField: Hashable {
    case text
}

struct AddNoteView: View {
    @Environment(\.managedObjectContext) var manObjContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    
    @FocusState private var focys: FocusableField? // автофокус на текстовое поле

    @StateObject var toggle = MyUserSettings() // Переводит кнопку "Done" лево/право

    
    var body: some View {
        VStack(alignment:toggle.handToggle ? .leading : .trailing) { // отслеживает и переключает
            TextEditor(text: $name)
                .myTextEdit()
                .focused($focys, equals: .text) // автофокус

            Button("Done") {
                if name == "" { // если нажали кнопку done, но при этом ничего не написали то ничего и не сохраним
                    dismiss()
                } else {
                    DataController().addNote(name: name, date: Date(), context: manObjContext)
                    dismiss()
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .buttonStyle(.bordered)
            .tint(.accentColor)

        }
        .onAppear {
            // так работает автоматическое фокусирование на поле
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                focys = .text
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
