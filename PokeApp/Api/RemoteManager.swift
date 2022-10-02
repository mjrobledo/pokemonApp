//
//
// RemoteManager.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation


final class APIClient {
    //APPError enum which shows all possible errors
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    //Result enum to show success or failure
    enum ApiResult<T> {
        case success(T)
        case failure(APPError)
    }
    
    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with api: Api, body: Data? = nil, getParams: String? = "", objectType: T.Type,  completion: @escaping (ApiResult<T>) -> Void) {
        
        var url = api.apiURL()
        
        if getParams != nil {
            url = api.apiURL(data: getParams)
        }
        
        guard let dataURL = URL(string: url) else {
            debugPrint("Url no valida \(url)")
            return
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        var request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        
        request.httpMethod = api.method.rawValue
        
        if body != nil {
            request.httpBody = body
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
         
        let session = URLSession(configuration: sessionConfiguration)
        
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 404 {
                    completion(ApiResult.failure(APPError.dataNotFound))
                }
            }
            
            guard error == nil else {
                completion(ApiResult.failure(APPError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(ApiResult.failure(APPError.dataNotFound))
                return
            }
            
            do {
                //create decodable object from data
               // debugPrint(String(data: data, encoding: .utf8) ?? "")
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(ApiResult.success(decodedObject))
            } catch let error {
                completion(ApiResult.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
}
