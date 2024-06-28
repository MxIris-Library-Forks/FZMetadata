//
//  NSMetadata+.swift
//
//
//  Created by Florian Zand on 28.08.22.
//

import Foundation
import FZSwiftUtils

extension NSMetadataQuery {
    
    /// The handlers that get called while gathering or results updates.
    public struct Handlers {
        /// The handler that gets called when the query begins with the initial result-gathering phase of the query.
        public var gatheringStarted: (()->())?
        /// The handler that gets called when the query has finished with the initial result-gathering phase of the query.
        public var gatheringFinished: (()->())?
        /// The handler that gets called while gathering when the results updates.
        public var gatheringProgressed: ((_ added: [MetadataItem], _ removed: [MetadataItem], _ changed: [MetadataItem])->())?
        /// The handler that gets called when the results updates.
        public var resultsUpdated: ((_ added: [MetadataItem], _ removed: [MetadataItem], _ changed: [MetadataItem])->())?
    }
    
    /// Handlers that get called while gathering or results updates.
    public var handlers: Handlers {
        get { getAssociatedValue("QueryHandlers", initialValue: Handlers()) }
        set { setAssociatedValue(newValue, key: "QueryHandlers")
            
            if newValue.gatheringStarted != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(gatheringStarted(_:)), name: .NSMetadataQueryDidStartGathering, object: self)
            } else {
                NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryDidStartGathering, object: self)
            }
            
            if newValue.gatheringProgressed != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(gatheringProgressed(_:)), name: .NSMetadataQueryGatheringProgress, object: self)
            } else {
                NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryGatheringProgress, object: self)
            }
            
            if newValue.gatheringFinished != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(gatheringFinished(_:)), name: .NSMetadataQueryDidFinishGathering, object: self)
            } else {
                NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryDidFinishGathering, object: self)
            }
            
            if newValue.resultsUpdated != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(resultsUpdated(_:)), name: .NSMetadataQueryDidUpdate, object: self)
            } else {
                NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryDidUpdate, object: self)
            }
        }
    }
    
    var notificationTokens: [Notification.Name:NotificationToken] {
        get { getAssociatedValue("notificationTokens", initialValue: [:]) }
        set { setAssociatedValue(newValue, key: "notificationTokens") }
    }
    
    @objc func gatheringStarted(_ notification: Notification) {
        handlers.gatheringStarted?()
    }
    
    @objc func gatheringProgressed(_ notification: Notification) {
        handlers.gatheringProgressed?(notification.added, notification.removed, notification.changed)
    }
    
    @objc func gatheringFinished(_ notification: Notification) {
        handlers.gatheringFinished?()
    }
    
    @objc func resultsUpdated(_ notification: Notification) {
        handlers.resultsUpdated?(notification.added, notification.removed, notification.changed)
    }
    
    /// Updates the values for the specified attribute names.
    func values(of attributes: [String], forResultsAt index: Int) -> [String: Any] {
        var values: [String: Any] = [:]
        attributes.forEach {
            values[$0] = value(ofAttribute: $0, forResultAt: index)
        }
        return values
    }
}
