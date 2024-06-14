//
//  NetworkManager.swift
//  LoadImages
//
//  Created by Sarath krishnaswamy on 14/06/24.
//

import Foundation

var baseUrl = URL(string: "https://www.jsonkeeper.com/b/6JS0")

class NetworkManager {
    func fetchImageData(completion: @escaping (Result<PhotoModel, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: baseUrl ?? URL(filePath: "")) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])
                completion(.failure(error))
                return
            }
            
            do {
                let imageData = try JSONDecoder().decode(PhotoModel.self, from: data)
                print(imageData)
                completion(.success(imageData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
