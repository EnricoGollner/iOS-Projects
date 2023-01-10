//
//  AsyncImage.swift
//  Cupcake Corner
//
//  Created by Enrico Sousa Gollner on 09/01/23.
//

import SwiftUI

struct AsyncImageLearn: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            if let image = phase.image{  // Loaded successfully
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil{
                Text("Error in loading the image.")
            } else{
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncImageLearn_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageLearn()
    }
}
