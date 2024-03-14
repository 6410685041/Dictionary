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
        NavigationView{
            VStack{
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 250, height: 180)
                Text("Dictionary")
                    .font(.system(size: 60))
                    .bold()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(UIColor(hex: "#bf5a1f")))
                        .frame(width: 330, height: 80)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                        .frame(width: 320, height: 70)
                    TextField("", text: $word)
                        .padding()
                }
                .frame(width: 330, height:80)
                .padding(.bottom)
                    
                NavigationLink("Enter") {
                    WordItemView(searchWord: word)
                }
                .disabled(word.isEmpty)
                .frame(width: 150, height: 40)
                .foregroundColor(.black)
                .background(Color(UIColor(hex: "#fbaf41")))
                
                Spacer()
                    .frame(height: 240)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#Preview {
    HomeView()
}
