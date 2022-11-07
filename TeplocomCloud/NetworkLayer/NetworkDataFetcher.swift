//
//  NetworkDataFetcher.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.08.2021.
//

import Foundation

final class NetworkDataFetcher {

    let networkService = NetworkService()

    func fetchGenericJSONData<T>(with urlString: String, of type: RequestType, header: String? = nil, parameters: [String: Any]? = nil, statusCodeCompletion: @escaping (Int?) -> Void = {_ in }, response: @escaping (T?) -> Void) where T: Decodable {

        networkService.request(with: urlString, of: type, header: header, parameters: parameters) { (data, error, statusCode) in
            if let error = error {
                print(" -- Error received requesting data in \(#function): \(error.localizedDescription)")
                response(nil)
                statusCodeCompletion(statusCode)
            }

            let decoded = self.decodeJSON(type: T.self, from: data)

            // Вывод пришедшего json в консоль, при необходимости раскомментировать
            /*
            print(T.Type.self)
            self.printJson(data: data)
            */

            response(decoded)
            statusCodeCompletion(statusCode)
        }
    }

    // Функция декодирует data в модель данных
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }

        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsonError {
            print(" -- Failed to decode JSON in \(#function): \(jsonError)")
            return nil
        }
    }

    // Вывести в консоль json
    func printJson(data: Data?) {
        guard let data = data else { return }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        } catch let jsonError {
            print(" -- Failed to print JSON in \(#function): \(jsonError)")
        }
    }
}
