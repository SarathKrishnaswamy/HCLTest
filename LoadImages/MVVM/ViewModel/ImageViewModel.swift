//
//  ImageViewModel.swift
//  LoadImages
//
//  Created by Sarath krishnaswamy on 14/06/24.
//

import Foundation

class ImageViewModel {
    var images: PhotoModel?
    private let networkService: NetworkManager
    
    var onDataFetched: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkService: NetworkManager = NetworkManager()) {
        self.networkService = networkService
    }
    
    func fetchData() {
        networkService.fetchImageData() { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.images = imageData
                self?.onDataFetched?()
            case .failure(let error):
                self?.onError?(error)
                print("Error fetching data: \(error)")
            }
        }
    }
}
