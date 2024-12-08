//
//  DataMgr.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import Foundation
import SQLite

class DBMgr {
    static let shared = DBMgr()
    
    public var isLoading = false

    private var connection: Connection?

    private(set) lazy var notesTable = NotesTable(connection: connection)

    private init() {
    }
    
    func connectToDB() async throws {
        do {
            let fileManager = FileManager.default
            let documentsURL = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let dbPath = documentsURL.appendingPathComponent("notes.sqlite3").path

            // Create a connection to the file-based database
            connection = try Connection(dbPath)
        } catch {
            throw DBError.connection
        }
    }
}
