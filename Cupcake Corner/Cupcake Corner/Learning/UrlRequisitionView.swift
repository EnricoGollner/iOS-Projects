//
//  UrlRequisition.swift
//  Cupcake Corner
//
//  Created by Enrico Sousa Gollner on 08/01/23.
//

import SwiftUI

// The API: https://itunes.apple.com/search?term=pink+floyd&entity=song

struct Response: Codable{
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct UrlRequisitionView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task{
            await loadData()
        }
    }
    
    func loadData() async{
        guard let url = URL(string: "https://itunes.apple.com/search?term=pink+floyd&entity=song") else{
            print("Invalid Url")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedData.results
            }
            
        } catch{
            print("Invalid data")
        }
    }
}

struct UrlRequisitionView_Previews: PreviewProvider {
    static var previews: some View {
        UrlRequisitionView()
    }
}
