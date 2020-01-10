//
//  ImageView.swift
//  Marvel
//
//  Created by Anton Kuznetsov on 9/7/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import UIKit

// используем вместо UIImageView наследника ImageView, чтобы подгружать изображение по ссылке URL, которую предоставляет Marvel при запросе списка героев
class ImageView: UIImageView {
    
    // MARK: - Private Methods
    
    // сохраняем изображение в кэше
    private func cacheImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
    
    // получаем изображение из кэша
    private func getCachedImage(url: URL) -> UIImage? {
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cacheResponse.data)
        }
        return nil
    }
    
    // MARK: - Public Methods
    
    func fetchImage(with url: String?) {
        guard let url = url else { return }
        guard let imageUrl = URL(string: url) else { return }
        
        if let cachedImage = getCachedImage(url: imageUrl) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error { print(error.localizedDescription); return }
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            if responseURL.absoluteString != url { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            self.cacheImage(data: data, response: response)
            
        }.resume()
    }
}
