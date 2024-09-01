//
//  File.swift
//  
//
//  Created by Florian Zand on 31.08.24.
//

import Foundation
import FZSwiftUtils

extension MetadataQuery {
    struct MappedResults: CustomStringConvertible {
        /// The files of the results.
        public let files: [File]
        /// The folders of the results.
        public let folders: [Folder]
        /// The items of the results.
        public let items: [MetadataItem]
        /// The url to the top level folder.
        public let topLevelURL: URL
        
        let level: Int
                
        public func file(at url: URL) -> File? {
            let pathComponents = url.pathComponents
            if pathComponents.count == level {
                return files.first(where: {$0.url == url })
            } else if pathComponents.count > level {
                return folders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.file(at: url ) }).first
            }
            return nil
        }
        
        public subscript(url: URL) -> MetadataItem? {
            item(at: url)
        }
        
        public func folder(at url: URL) -> Folder? {
            let pathComponents = url.pathComponents
            if pathComponents.count == level {
                return folders.first(where: {$0.url == url })
            } else if pathComponents.count > level {
                return folders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.folder(at: url ) }).first
            }
            return nil
        }
        
        func item(at url: URL) -> MetadataItem? {
            let pathComponents = url.pathComponents
            if pathComponents.count == level {
                return files.first(where: {$0.url == url })?.item
            } else if pathComponents.count > level {
                return folders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.item(at: url ) }).first
            }
            return nil
        }
        
        /// All files including the files of all folders.
        public var allFiles: [File] {
            files + folders.flatMap({$0.allFiles})
        }
        
        /// All folders including the subfolders of all folders.
        public var allFolders: [Folder] {
            folders + folders.flatMap({$0.allSubfolders})
        }
                
        init(_ items: [MetadataItem]) {
            let main = Folder(items)
            self.files = main.files
            self.folders = main.subfolders
            self.items = items
            self.level = main.level
            self.topLevelURL = main.url ?? URL(fileURLWithPath: "/")
        }
        
        public var description: String {
            var values: [String] = []
            values.append("MappedQueryResults(")
            values.append(contentsOf: Folder(files: files, subfolders: folders).strings(index: 1))
            values.append(")")
            return values.joined(separator: "\n")
        }
    }
}

extension MetadataQuery.MappedResults {
    public struct File: CustomStringConvertible {
        /// The url of the file.
        public let url: URL
        /// The metadata item of the file.
        public let item: MetadataItem
        
        init(_ item: MetadataItem, _ url: URL) {
            self.url = url
            self.item = item
        }
        
        public var description: String {
            url.lastPathComponent
        }
    }
}

extension MetadataQuery.MappedResults {
    public struct Folder {
        /// The files of the folder.
        public let files: [File]
        /// The subfolders of the folder.
        public let subfolders: [Folder]
        /// The url of the folder.
        public let url: URL?
        /// The metadata item of the folder.
        public let item: MetadataItem?
        let level: Int
        
        /// All subfolders.
        public var allSubfolders: [Folder] {
            subfolders + subfolders.flatMap({$0.allSubfolders})
        }
        
        /// All files including the files of all subfolders.
        public var allFiles: [File] {
            files + subfolders.flatMap({$0.allFiles})
        }
        
        /// All metadata items including the items of all subfolders.
        public var allItems: [MetadataItem] {
            files.compactMap({$0.item}) + subfolders.compactMap({$0.item}) + subfolders.flatMap({$0.allItems})
        }
        
        func file(at url: URL) -> File? {
            let pathComponents = url.pathComponents
            print(level, pathComponents.count, self.url ?? "nil", self.files.compactMap({$0.url}))
            if pathComponents.count-1 == level {
                return files.first(where: {$0.url == url })
            } else if pathComponents.count > level {
                return subfolders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.file(at: url ) }).first
            }
            return nil
        }
        
        func folder(at url: URL) -> Folder? {
            let pathComponents = url.pathComponents
            print(level, pathComponents.count, self.url ?? "nil", self.files.compactMap({$0.url}))
            if pathComponents.count == level {
                return self.url == url ? self : nil
            } else if pathComponents.count > level {
                return subfolders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.folder(at: url ) }).first
            }
            return nil
        }
        
        func item(at url: URL) -> MetadataItem? {
            let pathComponents = url.pathComponents
            if pathComponents.count-1 == level, let file = files.first(where: {$0.url == url }) {
                return file.item
            } else if pathComponents.count == level {
                return self.url == url ? self.item : nil
            } else if pathComponents.count > level {
                return subfolders.filter({ $0.url?.pathComponents[safe: level] == pathComponents[level] }).compactMap({ $0.item(at: url ) }).first
            }
            return nil
        }
        
        init(files: [File], subfolders: [Folder]) {
            self.files = files
            self.subfolders = subfolders
            self.item = nil
            self.url = nil
            self.level = .max
        }
                    
        init(_ items: [MetadataItem]) {
            let items: [(item: MetadataItem, url: URL)] = items.compactMap({ if let path = $0.path { return ($0, URL(fileURLWithPath: path)) } else { return nil } }).sorted(by: \.url.path)
            if items.isEmpty {
                self.files = []
                self.subfolders = []
                self.url = nil
                self.item = nil
                self.level = .max
            } else {
                let firstChangedIndex = items.compactMap({$0.1.pathComponents}).firstChangedIndex ?? 0
                let main = Folder(items, index: firstChangedIndex)
                self.files = main.files
                self.subfolders = main.subfolders
                self.item = main.item
                if let url = main.url {
                    self.url = url
                } else if let component = items.first?.url.pathComponents {
                    self.url = URL(pathComponents: component[safe: 0..<firstChangedIndex-1])
                } else {
                    self.url = nil
                }
                self.level = self.url?.pathComponents.count ?? .max
            }
        }
        
        init(_ items: [(item: MetadataItem, url: URL)], index: Int) {
            // Swift.print("folder", index, items.count)
            let dic = Dictionary(grouping: items, by: \.url.pathComponents[safe: index])
            var files: [File] = []
            var folders: [Folder] = []
            var url: URL?
            var item: MetadataItem?
            for val in dic {
                if val.key == nil, val.value.count == 1, let val = val.value.first, val.url.isDirectory {
                    url = val.url
                    item = val.item
                }
                guard val.key != nil else { continue }
                if val.value.count == 1, let val = val.value.first, val.url.isFile {
                    files.append(File(val.item, val.url))
                } else {
                    folders.append(Folder(val.value, index: index+1))
                }
            }
            self.files = files
            self.subfolders = folders
            self.url = url
            self.item = item
            self.level = self.url?.pathComponents.count ?? .max
        }
        
        func strings(index: Int = 0) -> [String] {
            let tab = Array(repeating: "\t", count: index).joined(separator: "")
            var values = subfolders.flatMap({ (tab + ($0.url?.lastPathComponent ?? "_Folder")) + $0.strings(index: index+1) })
            values += files.compactMap({ tab + $0.description })
            return values
        }
        
        func indexedStrings(index: Int = 0) -> [(index: Int, string: String)] {
            var values = subfolders.flatMap({ (index, $0.url?.lastPathComponent ?? "Folder") + $0.indexedStrings(index: index+1) })
            values += files.compactMap({ (index, $0.description) })
            return values
        }
    }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
    var firstChangedIndex: Int? {
        guard !isEmpty else { return nil }
        let maxIndex = (compactMap({$0.count}).max() ?? 0)
        return (0..<maxIndex).first(where: { index in compactMap({$0[safe: index]}).count != count })
    }
}
