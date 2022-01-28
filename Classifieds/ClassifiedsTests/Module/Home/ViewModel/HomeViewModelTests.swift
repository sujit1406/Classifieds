//
//  NowPlayingViewModelTests.swift
//  ClassifiedsTests
//
//  Created by Sujith Antony on 28.01.2022.
//  Copyright © 2022 Classifieds. All rights reserved.
//

import XCTest
@testable import Classifieds

class HomeViewModelTests: XCTestCase {
    var apiClient: MockAPIClient!
    private let imageUrl = "https://demo-app-photos-45687895456123.s3.amazonaws.com/c96e82f913034c27b291a1722613f162-thumbnail?AWSAccessKeyId=ASIASV3YI6A45J5VWSOV&Signature=MREUfzcXQ72pF59lSEq2j%2FXuOhg%3D&x-amz-security-token=IQoJb3JpZ2luX2VjELD%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQCzNwtcPhWjUWYcIhMXcRD6Tp4tzkB8EApv94Nn5v4FgAIgeqTi34U4l6FmuJWto4Hm5n0XkGPjMz3a6l9hzVV%2FKfoqnQII2f%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARADGgwxODQzOTg5NjY4NDEiDKweH97jSQu3qyzflyrxAXSRc0HO8Yd1VIMQauoiS6FQ9L3j%2BukFubsSKBnxiEnsLwp2EJ%2F70mqld1Ixj5QoztgVQZ4ndaiEU5vhIIKfMmrTaU98Y7k6Vy0wklqx4krJRJb%2BaDPwFpjAhZlvRWlEddZu7AdiKiilu6gANW67ImDZCSU7z2hR5lJLGu3y0LZ6qjsbpK7JPwyhcpN0d6g%2BdRncOTB5nKDREamPu56OBLfedJP5xOZ7HbtaPI3uPu7I9geWKWu6zctnriJYxn0HrfRP5%2BUk0JSCGQBd3HvsbNUA9%2FtX6kN0Ueza%2FhWIXnwJXFRUp2NSx937VWbsG%2B02gi0w05nQjwY6mgGZwVkJLu5%2F62T3oJOXT85PloqE3T%2FCnMZe3aKokP5Or22Vei19Pz8BCxkHmtLgTasy7iWwz9MNqKFAuGB0NAqlD1tMbU7kYpmM1W%2BYB%2BWq7GrCOER2SCzUbcOv%2B%2B772XPuuR4UCKt6aYAebbGpVMX8cNU%2BRlRPs76YXvE1qvXG9iAoBsmTFWscSfR2wRws%2BA5eV6UA2WD%2FMDKX&Expires=1643387625"
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        apiClient = MockAPIClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        apiClient = nil
    }

    override func tearDown() {
        super.tearDown()
    }

    override func setUp() {
        super.setUp()
    }
    
    func testFetchClassifieds() {
        let exp = self.expectation(description: "Classifieds Parsing")
        apiClient.getMockClassifieds { items, error in
            if error != nil {
                XCTFail("Parsing API failed")
            }
            print("items count is \(items.count)")
            XCTAssertTrue(items.count == 20, "Classifieds Parsing success")
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testImageDownload(){
        let exp = self.expectation(description: "Image Download")
        ImageDownloader.downloadImage(imageUrl) { image in
            guard let image = image, let data = UIImagePNGRepresentation(image) else {
                XCTFail("Data should not be nil")
                return
            }
            print("Downloaded \(data.count) bytes for image")
            XCTAssertTrue(data.count > 100, "Image Download success")
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testCaching(){
        let exp = self.expectation(description: "Caching Test")
        ImageDownloader.downloadImage(imageUrl) { [weak self] image in
            guard let `self` = self, let image = image, let data = UIImagePNGRepresentation(image) else {
                XCTFail("Data should not be nil")
                return
            }
            print("Downloaded \(data.count) bytes for image")
            XCTAssertTrue(data.count > 100, "Parsing success")
            ImageCache.shared.setObject(image, forKey: self.imageUrl as NSString)
            guard let cachedImage = ImageCache.shared.object(forKey: self.imageUrl as NSString) , let cacheddata = UIImagePNGRepresentation(cachedImage) else {
                XCTFail("Cached Image is nil")
                return
            }
            print("Downloaded bytes->\(data.count)  :: cached bytes->\(cacheddata.count)")
            XCTAssertTrue(cacheddata.count ==  data.count, "Downloaded image is fetched from cache successfully")
            exp.fulfill()

        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
