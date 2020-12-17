//
//  ApplicationInfo.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/12/17.
//

import Foundation

public struct ApplicationInfo: Equatable {
    public let version: String
    public let build: String
    public let sourceCodeURL: URL

    public init(version: String, build: String, sourceCodeURL: URL) {
        self.version = version
        self.build = build
        self.sourceCodeURL = sourceCodeURL
    }
}
