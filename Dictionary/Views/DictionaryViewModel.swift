//
//  DictionaryViewModel.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 12/3/2567 BE.
//

import Foundation

class DictionaryViewModel: ObservableObject {
    @Published var word: String = ""
    @Published var phonetic: String = ""
    @Published var definitions: String = ""
    @Published var origin: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var dictionaryManager = DictionaryManager()

    func fetchWordDetails(word: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {                
                let details = try await dictionaryManager.getword(word: word)

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.word = details.first?.word ?? "Not found"
                    self.phonetic = details.first?.phonetics.first?.text ?? "No phonetic available"
                    
                    var definitionsText = ""
                    for meaning in details.first?.meanings ?? [] {
                        definitionsText += "\(meaning.partOfSpeech):\n"
                        for definition in meaning.definitions {
                            definitionsText += "- \(definition.definition)\n"
                        }
                    }
                    self.definitions = definitionsText
                    self.origin = details.first?.origin ?? "No Origin"
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "There is no \"\(word)\" in Dictionary"
                }
            }
        }
    }
}
