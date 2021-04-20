// ----------------------------------------------------------------------------
//
//  DatabaseHelperZip.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2016, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsExtensions
import SwiftCommonsLang
import SwiftCommonsLogging
import ZIPFoundation

// ----------------------------------------------------------------------------

@available(*, deprecated)
public class DatabaseHelperZip: DatabaseHelper {

// MARK: - Construction

    @available(*, deprecated, message: "\n• Write a description.")
    public override init(
        databaseName: String?,
        version: Int,
        readonly: Bool = false,
        delegate: DatabaseOpenDelegate? = nil
    ) {

        super.init(databaseName: databaseName, version: version, readonly: readonly, delegate: delegate)
    }

// MARK: - Methods

    @available(*, deprecated, message: "\n• Write a description.")
    internal override func unpackDatabaseTemplate(databaseName: String, assetPath: URL) -> URL? {
        var path: URL?

        // Copy template file from application assets to the temporary directory
        if let tmpPath = makeTemplatePath(databaseName: databaseName) {

            // Remove previous template file
            FileManager.roxie_removeItem(at: tmpPath)

            // Unzip database template file from the assets
            if let archive = Archive(url: assetPath, accessMode: .read),
               let entry = archive[databaseName] {

                do {
                    _ = try archive.extract(entry, to: tmpPath, skipCRC32: true)
                    path = tmpPath
                }
                catch {
                    let message = "Failed to extract ‘\(databaseName)’ from archive ‘\(assetPath.path)’."
                    Logger.w(Roxie.typeName(of: self), message, error)
                }
            }
        }
        else {
            Roxie.fatalError("Could not make temporary path for database ‘\(databaseName)’.")
        }

        return path
    }
}
