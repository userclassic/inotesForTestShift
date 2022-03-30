//
//  SettingsView.swift
//  inotesForTest
//
//  Created by Владимир Осетров on 25.03.2022.
//

import SwiftUI

class MyUserSettings: ObservableObject {
    @AppStorage("Some_key") var handToggle = false
}

struct SettingsView: View {
    @ObservedObject var togol: MyUserSettings


    var body: some View {
        Form {
            Section("General") {
                Toggle("Left Hand", isOn: $togol.handToggle ) // $togol.handToggle
                    .tint(.accentColor)
                    .font(.headline.monospaced())

            }.font(.footnote.monospaced())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(togol: MyUserSettings())
    }
}
