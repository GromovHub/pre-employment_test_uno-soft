//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var VM: ViewModel
    @State var navigationTitle: String = "Speed Test"
    
    var body: some View {
        VStack {
            Spacer(minLength: 30)
                HStack(alignment: .top, spacing: 50) {
                    SpeedView(name: "Download", speed: $VM.downloadSpeed)
                    if VM.appSettings.measureUpload {
                        SpeedView(name: "Upload", speed: $VM.uploadSpeed)
                    }
            }
            
            Spacer(minLength: 30)
            Button("Start") {
                VM.getDownloadSpeed()
                if VM.appSettings.measureUpload {
                    VM.getUploadSpeed()
                }
                print("Start measuring")
            }
            Spacer(minLength: 30)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            Button("Settings") {
                VM.coordinatorDelegate?.show(screen: .settingsScreen)
            }
        })
    }
}

struct SpeedView: View {
    var name: String
    @Binding var speed: String
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
            Text(verbatim: name)
                .bold()
                .font(.title2)
            Text(verbatim: speed)
                .padding(.top, 30)
            
        }
    }
}

#Preview {
    NavigationStack {
        MainView(VM: ViewModel())
    }
}

