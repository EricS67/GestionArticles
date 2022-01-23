//
//  ContentView.swift
//  GestionArticles
//
//  Created by Eric savary on 16.01.22.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            ArticlesView().tabItem {
                Image(systemName: "newspaper")
                Text("Articles")
            }
            .tag(1)
            Text("Test").tabItem {
                Image(systemName: "newspaper")
                Text("Test")
            }
            .tag(2)
            
            
        }
        .padding(10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
