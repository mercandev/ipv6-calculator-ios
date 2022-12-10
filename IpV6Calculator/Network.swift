//
//  Network.swift
//  IpV6Calculator
//
//  Created by Kaan Mercan on 9.12.2022.
//

import Foundation

class Network{
    
    static let shared = APIService()
      
      func getRequest<T: Codable>(url: URL, type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
          
          let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
              guard let data = data, error == nil else {
                  print(error as Any)
                  errorHandler(error?.localizedDescription ?? "Error!")
                  return
              }
              
              if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                  print("status code is not 200")
                  errorHandler("Status code is not 200")
                  print(response as Any)
              }
              
              if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                  completionHandler(mappedResponse)
              }
          }
          
          task.resume()
      }
      
      func postRequest<T: Codable>(url: URL, params: [String: Any], type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
          let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
          
          let task = URLSession.shared.uploadTask(with: request, from: jsonData) { (data, response, error) in
              guard let data = data, error == nil else {
                  print(error as Any)
                  errorHandler(error?.localizedDescription ?? "Error!")
                  return
              }
              
              if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                  print("status code is not 200")
                  errorHandler("Status code is not 200")
                  print(response as Any)
              }
              
              if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                  completionHandler(mappedResponse)
              }
          }
          
          task.resume()
      }
}
