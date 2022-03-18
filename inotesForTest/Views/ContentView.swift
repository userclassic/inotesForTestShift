//
//  ContentView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 17.03.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var maneObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var note: FetchedResults<Notes>
    
    @State private var showAddView = false



    var body: some View {

        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach (note) { note in
                        NavigationLink(destination: EditNoteView(note: note) ){
                            VStack(alignment: .leading, spacing: 8){
                                Text("\(note.name!)")
                                    .lineLimit(2)
                                    .font(.headline.monospaced())
                                HStack {
                                    Text("\(note.date!,format: .dateTime)  ~ \(calcuTime(date:note.date!))")
                                        .font(.caption.italic().monospaced())
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delNote(offsets:))
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("AllNotes",displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        /*Button {
                            showAddView.toggle()
                            print("Show settings")
                        } label: {
                            Label ("Settings", systemImage: "person.fill")
                        }
                        Spacer(minLength: 16)*/
                        Button {
                            showAddView.toggle()
                        } label: {
                            Label ("add note", systemImage: "plus.app")
                        }
                    }
                }
                /*ToolbarItem (placement: .navigationBarLeading) {
                    //EditButton()
                    Text("16 Notes ")
                        .foregroundColor(.secondary)
                        .font(.system(.footnote))
                }*/
            }
            .sheet(isPresented: $showAddView) {
                AddNoteView()
            }
        }
        .navigationViewStyle(.stack)
    }
    private func delNote (offsets: IndexSet) {
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
