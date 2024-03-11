//
//  ModelData.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import Foundation

var previewWord: ResponseBody = load("wordData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename)")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename)")
    }
    
    do {
        let decode = try JSONDecoder().decode(T.self, from: data)
        return decode
    } catch {
        fatalError("Couldn't parse \(filename)")
    }
    
}
