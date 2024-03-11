//
//  WordItem.swift
//  Dictionary
//
//  Created by ชลิศา ธรรมราช on 11/3/2567 BE.
//

import SwiftUI

struct WordItem: View {
    @State var word: ResponseBody
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WordItem_Previews: PreviewProvider {
    static var previews: some View {
        WordItem(word: previewWord)
    }
}
