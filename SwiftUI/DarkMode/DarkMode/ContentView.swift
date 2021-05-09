//
//  ContentView.swift
//  DarkMode
//
//  Created by lee on 2021/05/09.
//

import SwiftUI

struct ContentView: View {

    @State private var shoudShowAlert: Bool = false

    @Environment(\.colorScheme) private var scheme: ColorScheme

    var body: some View {
        ZStack {
            Theme.backgroundColor(for: scheme)

            VStack {
                Spacer()

                Button(action: {
                    shoudShowAlert.toggle()
                }, label: {
                    Text("Button")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Theme.buttonColor(for: scheme))
                        .cornerRadius(13)
                        .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.white, lineWidth: 3))

                })
                .alert(isPresented: $shoudShowAlert, content: {
                    Alert(
                        title: Text("DarkMode"),
                        message: Text("\(scheme == .dark ? "true" : "false")"),
                        dismissButton: .default(Text("close"))
                    )
                })

                Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("Light Mode")

            ContentView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
