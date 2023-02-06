//
//  NetworkServiceTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 09.10.2022.
//

import XCTest
@testable import TeplocomCloud

class NetworkServiceTests: XCTestCase {

    // MARK: - System Under Test

    var sut: DataFetcherService!
    var mockURLSession: MockURLSession!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut = DataFetcherService()
        sut.dataFethcer.networkService.urlSession = mockURLSession
    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func jsonTestsSetup() {
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        sut.dataFethcer.networkService.urlSession = mockURLSession
    }

    func testGetAuthCodeCorrectHostAndPath() {
        let completion = { (_: AuthCodeBackendModel?) in }
        sut.getAuthCode(parameters: ["": ""], completion: completion)

        XCTAssertEqual(mockURLSession.urlComponents?.host, "api-auth.bast.ru")
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/api/v1/auth/request-code/no-captcha")
    }

    func testAuthCodeInvalidJsonReturnsError() {
        jsonTestsSetup()

        let errorExpectation = expectation(description: "Error expectation")
        var caughtError: AuthCodeBackendModel?

        sut.getAuthCode(parameters: ["": ""]) { model in
            caughtError = model == nil ? AuthCodeBackendModel(floodWait: 0, error: "Foo") : nil
            errorExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

    func testLoginCorrectHostAndPath() {
        let completion = { (_: LoginBackendModel?) in }
        sut.login(parameters: ["": ""], completion: completion)

        XCTAssertEqual(mockURLSession.urlComponents?.host, "api-auth.bast.ru")
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/api/v1/auth/login")
    }

    func testLoginInvalidJsonReturnsError() {
        jsonTestsSetup()

        let errorExpextations = expectation(description: "Error expectation")
        var caughtError: LoginBackendModel?

        sut.login(parameters: ["": ""]) { model in
            caughtError = model == nil ? LoginBackendModel() : nil
            errorExpextations.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

    func testRefreshTokenHostAndPath() {
        let completion = { (_: ServiceFeedbackModel?) in }
        sut.refreshToken(refreshToken: "", completion: completion)

        XCTAssertEqual(mockURLSession.urlComponents?.host, "api-auth.bast.ru")
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/api/v1/auth/refresh/")
    }

    func testRefreshInvalidJsonReturnsError() {
        jsonTestsSetup()

        let errorExpextations = expectation(description: "Error expectation")
        var caughtError: ServiceFeedbackModel?

        sut.refreshToken(refreshToken: "") { model in
            caughtError = model == nil ? ServiceFeedbackModel(jwt: "Foo", refreshToken: "Bar", error: "Baz") : nil
            errorExpextations.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
}

extension NetworkServiceTests {

    // MARK: - MockURLSession

    class MockURLSession: URLSessionProtocol {

        var url: URL?
        let mockDataTask: MockURLSessionDataTask

        var urlComponents: URLComponents? {
            // Удалось ли получить url из MockURLSession
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }

        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }

        func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            guard let urlFromRequest = request.url else { fatalError() }
            self.url = urlFromRequest
            mockDataTask.completionHandler = completionHandler
            return  mockDataTask
        }
    }

    // MARK: - MockURLSessionDataTask

    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?

        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?

        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }

        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}
