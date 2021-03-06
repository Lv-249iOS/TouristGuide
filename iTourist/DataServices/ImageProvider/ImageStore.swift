//
//  ImageStore.swift
//  iTourist
//
//  Created by Alejandro Del Rio Albrechet on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class ImageStore {

    var storageLimit = 50
    
    private var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var countImagesInDirectory: Int? {
        let imgDirPath = documentsURL.appendingPathComponent("images")
        let directoryContents = try? FileManager.default.contentsOfDirectory(atPath: imgDirPath.path)
        return directoryContents?.count
    }
    
    func getImage(by filename: String) throws -> UIImage? {
        let fullPath = try self.fileInDocumentsDirectory(filename)
        let image = UIImage(contentsOfFile: fullPath)
        
        return image
    }
    
    /// Adds name of file to self documents area and removes file in the path
    func removeImage(with filename: String) throws {
        let fullPath = try self.fileInDocumentsDirectory(filename)
        try FileManager.default.removeItem(atPath: fullPath)
        print("REMOVED from file system")
    }
    
    /// Creates jpeg data representation for image and save it
    func save(image: UIImage, with filename: String) {
        if let path = try? fileInDocumentsDirectory(filename) {
            guard let jpgImageData = UIImageJPEGRepresentation(image, 1.0) else { return }
            try? jpgImageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
            print("SAVED in file system")
        }
    }
    
    /// Returns path to images folder in directory if the folder exists if not - creates and returns path
    private func fileInDocumentsDirectory(_ filename: String) throws -> String {
        var fileURL = self.documentsURL.appendingPathComponent("images")
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
        }
        
        fileURL = fileURL.appendingPathComponent(filename)
        
        return fileURL.path
    }
    
    /// Cleans all files in images folder in current documents area
    func clearAllFilesFromDirectory() {
        let imgDirPath = documentsURL.appendingPathComponent("images")
        let directoryContents = try? FileManager.default.contentsOfDirectory(atPath: imgDirPath.path)
        
        guard let contents = directoryContents else {
            print("Could not retrieve directory")
            return
        }
        
        for path in contents {
            let fullPath = imgDirPath.appendingPathComponent(path)
            try? FileManager.default.removeItem(atPath: fullPath.path)
        }
    }
}
