//
//  ContentView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI
import CoreData
// общие стили
extension View {
    func myTextEdit() -> some View { // дополнительний стиль
        self
            .padding()
            .lineSpacing(.leastNormalMagnitude)
            .font(.title2.weight(.thin).monospaced())
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var maneObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var note: FetchedResults<Notes>
    
    @State private var showAddView = false //Переключатели всплывающего окна
    @State private var showSettings = false
    
    @StateObject var globa = DataController()

    //@StateObject var toggle = MyUserSettings() // если переносить и тулбаритемы


    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach (note) { note in
                        NavigationLink(destination: EditNoteView(note: note) ){
                            VStack(alignment: .leading, spacing: 8){
                                Text("\(note.name!)")
                                    .lineLimit(2)
                                    .font(.headline.monospaced()) //основной шрифт
                                HStack {
                                    // тут время редактирования и как давно редактировал
                                    Text("\(note.date!,format: .dateTime)  ~ \(calcuTime(date:note.date!))")
                                        .font(.caption.italic().monospaced())
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delNote(offsets:)) // функция удаления
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("AllNotes",displayMode: .automatic)

            .toolbar {
                ToolbarItem {
                    HStack{
                        Button {
                            showSettings.toggle()
                            print("Show settings")
                        } label: {
                            Label ("Settings", systemImage: "person.fill")
                        }
                        Spacer(minLength: 16)
                        Button {
                            showAddView.toggle()
                        } label: {
                            Label ("add note", systemImage: "plus.app")
                        }
                    }
                }

                ToolbarItem {
                    // добавить подсчет заметок
                    Text("16 Notes ")
                        .foregroundColor(.secondary)
                        .font(.system(.footnote))
                }

            }
            .sheet(isPresented: $showAddView) {
                AddNoteView()

            }
            .sheet(isPresented: $showSettings) {
                SettingsView(togol: MyUserSettings())
            }
        }
        .navigationViewStyle(.stack) 
    }
    private func delNote (offsets: IndexSet) { // функция удаления
        withAnimation {
            offsets.map {note[$0]}.forEach(maneObjContext.delete)
            DataController().save(context: maneObjContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
