//
//  ContentView.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import SwiftUI

struct HomeView: View {
    @State var word = ""
    @State var dictionaryManager = DictionaryManager()
    
    var body: some View {
        VStack {
            Text("Dictionary")
                .font(.system(size: 30))
                .bold()
            TextField("", text: $word)
                .padding()
                .border(Color.blue, width: 4)
            Button("Enter"){
                
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
