//
//  UIImageViewExtansion.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {

    /// 異步載入圖片，這裡使用快取機制，如果快取存在相同的Key就Set
    /// - Parameter url: 圖片URL(KEY)
    func asyncLoadImageWithURL(url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image: UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            } else {
                setImage(image: nil)
            }
        }
    }
}
