//
//  ViewControllerTest.swift
//  LoadImagesTests
//
//  Created by Sarath krishnaswamy on 14/06/24.
//

import XCTest
@testable import LoadImages

class ViewModelTests: XCTestCase {

    var viewModel: ImageViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = ImageViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchDataSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Data fetched successfully")
        let mockImageData = PhotoModel(total: 1, totalHits: 1, hits: [PhotoModel.Hit(id: 1, pageURL: "https://example.com/image.jpg", type: "Photo", tags: "Nature", previewURL: "https://example.com/image.jpg")])
        mockNetworkService.mockData = Result.success(mockImageData)

        // When
        viewModel.fetchData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.images?.hits.count, 4)
            //XCTAssertEqual(self.viewModel.images?.hits.first?.previewURL, "https://example.com/image.jpg")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchDataFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Data fetch failed")
        let mockError = NSError(domain: "MockError", code: 500, userInfo: nil)
        mockNetworkService.mockData = Result.failure(mockError)

        // When
        viewModel.fetchData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.images)
            //XCTAssertNotNil(self.viewModel.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock Network Service
class MockNetworkService: NetworkManager {
    var mockData: Result<PhotoModel, Error>?

    func fetchData(completion: @escaping (Result<PhotoModel, Error>) -> Void) {
        if let mockData = mockData {
            completion(mockData)
        }
    }
}

