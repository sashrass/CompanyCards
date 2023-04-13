//
//  Networking.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import Foundation

enum RequestType {
    case all
    case ideal
    case long
    case error
}

final class WebService {
    
    func fetchCards(_ requestType: RequestType, offset: Int, completion: @escaping (Result<[CompanyResponse], Error>) -> Void) {
        var url = "http://dev.bonusmoney.pro/mobileapp"
        
        switch requestType {
        case .all:
            url += "/getAllCompanies"
        case .ideal:
            url += "/getAllCompaniesIdeal"
        case .long:
            url += "/getAllCompaniesLong"
        case .error:
            url += "/getAllCompaniesError"
        }
        
        let httpBody = ["offset": offset]
        
        request(url: URL(string: url)!, responseType: [CompanyResponse].self, httpBody: httpBody, completion: completion)
    }
    
    private func request<T: Decodable>(url: URL, responseType: T.Type, httpBody: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        
        let body = try? JSONSerialization.data(withJSONObject: httpBody)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(UnknownError()))
                return
            }
          
            if let data = data, statusCode == 200 {
  
                guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(DecodeError()))
                    return
                }

                completion(.success(decoded))
                
            } else if statusCode == 400 {
                
                guard let data = data, let decodedError = try? JSONDecoder().decode(BadRequestError.self, from: data) else {
                    completion(.failure(BadRequestError(message: "bad request")))
                    return
                }
                
                completion(.failure(decodedError))
                
            } else if statusCode == 401 {
                completion(.failure(AuthorizationError()))
                
            } else {
                completion(.failure(ServerError()))
            }
        }.resume()
        
        
    }

}
