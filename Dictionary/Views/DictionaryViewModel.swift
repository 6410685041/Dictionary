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
    @Published var definitions: [Definition] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var dictionaryManager = DictionaryManager()

    func fetchWordDetails(word: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {                
                print(word)
                let details = try await dictionaryManager.getword(word: word)

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.word = details.first?.word ?? "Not found"
                    self.phonetic = details.first?.phonetics.first?.text ?? "No phonetic available"
                    
                    for meaning in details.first?.meanings ?? [] {
                        let newDefinition = Definition(partOfSpeech: meaning.partOfSpeech, definitions: meaning.definitions.map { $0.definition })
                        self.definitions.append(newDefinition)
                    }
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

class Definition: Identifiable {
    @Published var partOfSpeech: String=""
    @Published var definitions: [String]=[]
    
    init(partOfSpeech: String, definitions: [String]) {
        self.partOfSpeech = partOfSpeech
        self.definitions = definitions
    }
    
    func setDefinition(_ definition: String) {
        self.definitions.append(definition)
    }
    
    func setPartOfSpeech(_ partOfSpeech: String) {
        self.partOfSpeech = partOfSpeech
    }
    
    func getDefinition() -> String {
        var allDefinitionsText = ""
        
        for definition in definitions {
            allDefinitionsText += "   - \(definition)\n"
        }
        
        return allDefinitionsText
    }
}
