//
//  DictionaryManager.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import Foundation

class DictionaryManager {
    
    func getWord(word: String) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
}

struct ResponseBody: Decodable {
    var word: String
    var origin: String?
    var phonetic: String?
    var phonetics: Array<Phonetic>
    var meanings: Array<Meaning>
    
    // if it error will display this text
    var title: String?
    var message: String?
    var resolution: String?
    
    struct Phonetic: Decodable {
        var text: String?
        var audio: String?
        var license: String?
        var url: String?
        var sourceUrls: String?
    }
    
    struct Meaning: Decodable {
        var partOfSpeech: String
        var definitions: Array<Definition>
    }
    
    struct Definition: Decodable{
        var definition: String
        var example: String
        var synonyms: Array<String>?
        var antonyms: Array<String>?
    }
}
