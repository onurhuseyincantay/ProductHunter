//
//  NetworkService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

class NetworkService<T: NetworkTarget> { }

// MARK: - Public
extension NetworkService {
  
  /// Makes a request for a Decodable Response
  /// - Parameters:
  ///   - target: TargetType to be targeted
  ///   - completion: Result with Success(Expected Decodable Object Type) or Failure(NetworkError)
  func request<D: Decodable>(target: T, completion: @escaping (Result<D, NetworkError>) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      let request = self.prepareRequest(from: target)
      URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard response != nil, let data = data else {
          if let error = error {
            completion(.failure(.sessionError(error)))
          } else {
            completion(.failure(.unknown))
          }
          return
        }
        do {
          let model = try JSONDecoder().decode(D.self, from: data)
          completion(.success(model))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }.resume()
    }
  }
  
  /// Makes a request
  /// - Parameters:
  ///   - target: TargetType to be targeted
  ///   - completion: Result with Success(Void) or Failure(NetworkError)
  func requestPlain(target: T, completion: @escaping (Result<Void, NetworkError>) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      let request = self.prepareRequest(from: target)
      URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let response = response as? HTTPURLResponse else {
          if let error = error {
            completion(.failure(.sessionError(error)))
          } else {
            completion(.failure(.unknown))
          }
          return
        }
        if (200..<300).contains(response.statusCode) {
          completion(.success(()))
        } else {
          completion(.failure(.unsucessfulStatusCode(code: response.statusCode)))
        }
      }.resume()
    }
  }
}

// MARK: - Private
private extension NetworkService {
  
  /// Prepares request  from TargetType
  /// - Parameter target: TargetType to be prepared
  /// - Returns: Prepared Request
  func prepareRequest(from target: T) -> URLRequest {
    var request: URLRequest!
    let pathAppended = target.baseURL.appendingPathComponent(target.path)
    
    switch target.workType {
    case .requestPlain:
      request = URLRequest(url: pathAppended)
      
    case let .requestWithUrlParameters(parameters):
      let queryGeneratedURL = pathAppended.generateUrlWithQuery(with: parameters)
      request = URLRequest(url: queryGeneratedURL)
      
    case let .requestWithBodyParameters(parameters):
      let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      request = URLRequest(url: pathAppended)
      request.httpBody = data
    }
    request.httpMethod = target.methodType.rawValue
    request.addValue(target.methodType.rawValue, forHTTPHeaderField: "Content-Type")
    return request
  }
  
}
