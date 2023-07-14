//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Juhyun Yun on 2022/10/25.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()

    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safedata = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safedata)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
