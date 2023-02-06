//
//  NetworkService.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.08.2021.
//

import Foundation

// MARK: - URLSessionProtocol
/// Need for Unit tests
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

// MARK: - NetworkService

final class NetworkService {

    lazy var urlSession: URLSessionProtocol = URLSession.shared

    // Основной метод
    func request(with urlString: String, of type: RequestType, header: String?, parameters: [String: Any]?, completion: @escaping (Data?, Error?, Int?) -> Void) {

        guard let url = URL(string: urlString) else {
            print(" -- \(#function): Failed to convert string in URL")
            return
        }

        guard let request = createRequest(of: type, with: url, header: header, parameters: parameters) else { return }
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    // Создаем dataTask
    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?, Int?) -> Void) -> URLSessionDataTask {
        return urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return completion(nil, error, 500)
                }

                // Напечатать код ответа сервера
                var statusCode = 0
                if let httpResponse = response as? HTTPURLResponse {
                    // print(httpResponse.statusCode)
                    statusCode = httpResponse.statusCode
                }
                completion(data, error, statusCode)
            }
        }
    }

    // Конфигурируем запрос
    private func createRequest(of type: RequestType, with url: URL, header: String?, parameters: [String: Any]?) -> URLRequest? {

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        switch type {
        case .get:
            request.httpMethod = "GET"
            return request

        case .getWithHeader:
            request.httpMethod = "GET"
            if header != nil {
                request.addValue(header!, forHTTPHeaderField: "Authorization")
            } else {
                print("no heaeder")
            }
            return request

        case .post:
            request.httpMethod = "POST"
            if parameters != nil {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: []) else {
                    print(" -- \(#function): Failed to make httpBody in JSONSerialization")
                    return nil
                }
                request.httpBody = httpBody
            }

            return request

        case .postWithHeader:
            request.httpMethod = "POST"
            if header != nil, parameters != nil {
                request.addValue(header!, forHTTPHeaderField: "Authorization")
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: []) else {
                    print(" -- \(#function): Failed to make httpBody in JSONSerialization")
                    return nil
                }
                request.httpBody = httpBody
            }

            return request

        case .putWithHeader:
            request.httpMethod = "PUT"

            if header != nil, parameters != nil {
                request.addValue(header!, forHTTPHeaderField: "Authorization")
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: []) else {
                    print(" -- \(#function): Failed to make httpBody in JSONSerialization")
                    return nil
                }
                request.httpBody = httpBody
            }

            return request

        case .delete:
            request.httpMethod = "DELETE"
            if header != nil {
                request.addValue(header!, forHTTPHeaderField: "Authorization")
            }

            return request
        }
    }
}
