//
//  ImageDataSource.swift
//  test
//
//  Created by Alexey Kuznetsov on 09.03.2021.
//

import Foundation
import UIKit

struct Picture {
    var image: UIImage?
    var height: Int
    var width: Int
}

class ImageDataSource {
  
    private var pictures = [Picture]()
    private let imagesCount = 27
    private let maxHeight = 2
    private let maxWidth = 4
    
    var count: Int {
        return pictures.count
    }

    init() {
        self.loadImages()
    }

    private func loadImages() {
        for number in 1...imagesCount {
            let picture = Picture(image: UIImage(named: "\(number).jpg") ?? nil,
                                  height: Int.random(in: 1...maxHeight),
                                  width: Int.random(in: 1...maxWidth))
            pictures.append(picture)
        }
    }

    subscript(index: Int) -> Picture {
        return pictures[index]
    }

    func moveWithReorder(_ fromIndex: Int, toIndex: Int) {
        let picture = pictures.remove(at: fromIndex)
        pictures.insert(picture, at: toIndex)
    }
}
