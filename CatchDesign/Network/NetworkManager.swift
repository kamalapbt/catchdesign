//
//  NetworkManager.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 15/11/21.
//

import Foundation

protocol NetworkSession {
    func fetchData(_ endpoint: Endpoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func fetchData(_ endpoint: Endpoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request: URLRequest = URLRequest(url: endpoint.url)
        
        
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}

class NetworkManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func fetchRequest(_ endpoint: Endpoint, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        session.fetchData(endpoint) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data, let _ = response {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(ApiError.unKnown))
            }
        }
    }
    
}
