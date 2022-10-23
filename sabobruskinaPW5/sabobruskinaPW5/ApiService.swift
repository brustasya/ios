//
//  ApiService.swift
//  sabobruskinaPW5
//
//  Created by Станислава on 23.10.2022.
//

import Foundation

public enum ApiResult {
    case failure(error: Error)
    case success(articles: [NewsSource.Article])
}

public struct NewsSource: Codable {
    let status: String
    let articles: [Article]
    let totalResults: Int
    
    public struct Article: Codable {
        let url: String
        let urlToImage: String?
        
        let publishedAt: String
        
        let content: String?
        let title: String
        
        let source: Source
        let author: String?
        let articleDescription: String?
        
        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, publishedAt, content
        }
        
        struct Source: Codable {
            let id: String?
            let name: String
        }
    }
}

class ApiService {
    static var shared = ApiService()
    static var key = "bff8bdaf03b8438eb0c343824a24a174"
    public var articles: [NewsSource.Article] = []
    
    private func getURL() -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(ApiService.key)")
    }
    
    func getTopStories(_ completion: @escaping (ApiResult?)->()) {
        guard let url = getURL() else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(ApiResult.failure(error: error))
                return
            }
            
            if let data = data {
                let articles = try? JSONDecoder().decode(NewsSource.self, from: data).articles
                completion(ApiResult.success(articles: articles ?? []))
            }
        }.resume()
    }
    
}
