//
//  WordItem.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import SwiftUI

struct WordItemView: View {
    let searchWord: String
    @StateObject private var viewModel = DictionaryViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text(viewModel.word)
                        .font(.title)
                    
                    Text(viewModel.phonetic)
                        .font(.subheadline)
                        .padding()
                    
                    Text(viewModel.origin)
                    
                    ScrollView {
                        Text(viewModel.definitions)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchWordDetails(word: searchWord)
        }
    }
}

#Preview {
    WordItemView(
        searchWord: "example"
    )
}
