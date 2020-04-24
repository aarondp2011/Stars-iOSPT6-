//
//  StarsController.swift
//  Stars (iOSPT6)
//
//  Created by Aaron Peterson on 4/23/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
//

import Foundation

class StarController {
    
    init() {
        self.loadFromPersistentStore()
    }
    
    // Data Set - 1 source of truth
    private(set) var stars: [Star] = []
    
    // CRUD
    // Create
    @discardableResult func createStar(with name: String, distance: Double) -> Star {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        self.saveToPersistentStore()
        return star
    }
    
    // Read
    
    // Uodate
    
    // Delete
    
    // MARK: - Persistance Functions
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("stars.plist")
    }
    
    // Save
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
            NSLog("Error saving stars data: \(error)")
        }
        
    }
    
    // Load
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let  data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            stars = try decoder.decode([Star].self, from: data)
        } catch {
            NSLog("Error loading stars data: \(error)")
        }
    }
}
