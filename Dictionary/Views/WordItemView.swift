//
//  WordItemView.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 13/3/2567 BE.
//

import SwiftUI

struct WordItemView: View {
    let searchWord: String
    @StateObject private var viewModel = DictionaryViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(UIColor(hex: "#bf5a1f")))
                .frame(width: 350, height: 700)
            RoundedRectangle(cornerRadius: 21)
                .fill(.white)
                .frame(width: 340, height: 690)
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        Text(viewModel.word)
                            .font(.system(size: 30))
                            .underline()
                            .foregroundColor(Color(UIColor(hex: "#fbaf41")))
                        
                        Text(viewModel.phonetic)
                            .font(.subheadline)
                            .padding(.bottom, 30)
                            .padding(.top, 0.5)
                        
                        VStack(alignment: .leading) {
                            Text("Definitions:")
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color(UIColor(hex: "#fbaf41")))
                            VStack{
                                ScrollView {
                                    ForEach(viewModel.definitions) { definition in
                                        Text(definition.partOfSpeech)
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(Color(UIColor(hex: "#fbaf41")))
                                        Text(definition.getDefinition())
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                            .padding(.leading)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchWordDetails(word: searchWord)
            }
            .padding(30)
            .navigationBarBackButtonHidden(true) // Hides the default back button
                    .navigationBarItems(leading: Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                            Spacer()
                                .frame(width: 200)
                            Image("Logo")
                                .resizable()
                                .frame(width: 80, height: 60)
                        }
                        .foregroundColor(Color(UIColor(hex: "#bf5a1f")))
                    })
        }
        .padding(20)
        .background(
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    WordItemView(
        searchWord: "Happy"
    )
}

