//
//  DictionaryManager.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import Foundation

class DictionaryManager {
    func getword(word: String) async throws -> [ResponseBody] {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let decodedData = try decoder.decode([ResponseBody].self, from: data)
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var word: String
    var origin: String?
    var phonetic: String?
    var phonetics: [Phonetic]
    var meanings: [Meaning]
    
    // if it error will display this text
    var title: String?
    var message: String?
    var resolution: String?
    
    struct Phonetic: Decodable {
        var text: String?
        var audio: String?
        var license: License?
        var url: String?
        var sourceUrls: String?
    }
    
    struct Meaning: Decodable {
        var partOfSpeech: String
        var definitions: [Definition]
    }
    
    struct Definition: Decodable{
        var definition: String
        var example: String?
        var synonyms: [String]?
        var antonyms: [String]?
    }
    
    struct License: Decodable {
        var name: String
        var url: String
    }
}
