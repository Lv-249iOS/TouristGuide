//
//  ImageStore.swift
//  iTourist
//
//  Created by Alejandro Del Rio Albrechet on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class ImageStore {
    
    private var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func getImage(by filename: String) throws -> UIImage? {
        let fullPath = try self.fileInDocumentsDirectory(filename)
        let image = UIImage(contentsOfFile: fullPath)
        
        return image
    }
    
    func removeImage(with filename: String) throws {
        let fullPath = try self.fileInDocumentsDirectory(filename)
        try FileManager.default.removeItem(atPath: fullPath)
        print("REMOVED from file system")
    }
    
    func save(image: UIImage, with filename: String) {
        if let path = try? fileInDocumentsDirectory(filename) {
            guard let jpgImageData = UIImageJPEGRepresentation(image, 1.0) else { return }
            try? jpgImageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
            print("SAVED in file system")
        }
    }
    
    private func fileInDocumentsDirectory(_ filename: String) throws -> String {
        var fileURL = self.documentsURL.appendingPathComponent("images")
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
        }
        
        fileURL = fileURL.appendingPathComponent(filename)
        return fileURL.path
    }
}
