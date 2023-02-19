//
//  GravatarImageService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation
import UIKit

class GravatarImageService {

    static public let shared: GravatarImageService = .init()

    private var cachedImages: NSCache<NSString, UIImage>
    private let endpoint = "https://gravatar.com/avatar/"
    private let endpointParameter = "?d=identicon"

    private init() {
        cachedImages = NSCache()
    }

    private func getCached(url: NSString) -> UIImage? {
        return cachedImages.object(forKey: url)
    }

    func loadImage(for email: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        let hashedEmail = email.md5()

        // check if image was already downloaded
        if let image = getCached(url: hashedEmail as NSString) {
            completion(.success(image))
            return
        }

        // compose gravatar endpoint
        guard let url = URL(string: endpoint + hashedEmail + endpointParameter) else {
            completion(.failure(.invalidUrl))
            return
        }

        let request = URLRequest(url: url)

        // download image
        let loadImageTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
            guard let strongSelf = self else {
                completion(.failure(.otherProblem))
                return
            }

            // check for valid response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ..< 300).contains(httpResponse.statusCode) else {
                completion(.failure(.responseProblem))
                return
            }

            // check if data can be read
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(.decodingProblem))
                return
            }

            // return and cache image for future use
            strongSelf.cachedImages.setObject(image, forKey: hashedEmail as NSString)
            completion(.success(image))
        }

        loadImageTask.resume()
    }
}
