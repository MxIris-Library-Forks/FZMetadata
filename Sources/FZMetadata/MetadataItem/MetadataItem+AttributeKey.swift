//
//  MetadataItem+AttributeKey.swift
//
//
//  Created by Florian Zand on 22.05.22.
//

import Foundation

extension MetadataItem {
    static var attributeKeys: [PartialKeyPath<MetadataItem>: String] {
        var attributeKeys = _attributeKeys
        if #available(macOS 11.0, iOS 14.0, tvOS 14.0, macCatalyst 14.0, *) {
            attributeKeys[\.contentType] = "kMDItemContentType"
            attributeKeys[\.contentTypeTree] = "kMDItemContentTypeTree"
        }
        return attributeKeys
    }

    static let _attributeKeys: [PartialKeyPath<MetadataItem>: String] =
        [
            \.url: "kMDItemURL",
            \.path: "kMDItemPath",
            \.fileName: "kMDItemFSName",
            \.displayName: "kMDItemDisplayName",
            \.alternateNames: "kMDItemAlternateNames",
            \.fileExtension: "kMDItemFSExtension",
            \.fileSizeBytes: "kMDItemFSSize",
            \.fileSize: "kMDItemFSSize",
            \.fileIsInvisible: "kMDItemFSInvisible",
            \.fileExtensionIsHidden: "kMDItemFSIsExtensionHidden",
            \.fileType: "kMDItemContentTypeTree",
            \.contentTypeIdentifier: "kMDItemContentType",
            \.contentTypeTreeIdentifiers: "kMDItemContentTypeTree",
            \.creationDate: "kMDItemFSCreationDate",
            \.lastUsedDate: "kMDItemLastUsedDate",
            \.lastUsageDates: "kMDItemUsedDates",
            \.attributeModificationDate: "kMDItemAttributeChangeDate",
            \.contentCreationDate: "kMDItemContentCreationDate",
            \.contentChangeDate: "kMDItemFSContentChangeDate",
            \.contentModificationDate: "kMDItemContentModificationDate",
            \.addedDate: "kMDItemDateAdded",
            \.downloadedDate: "kMDItemDownloadedDate",
            \.purchaseDate: "kMDItemPurchaseDate",
            \.dueDate: "kMDItemDueDate",
            \.directoryFilesCount: "kMDItemFSNodeCount",
            \.description: "kMDItemDescription",
            \.kind: "kMDItemKind",
            \.information: "kMDItemInformation",
            \.identifier: "kMDItemIdentifier",
            \.keywords: "kMDItemwords",
            \.title: "kMDItemTitle",
            \.album: "kMDItemAlbum",
            \.authors: "kMDItemAuthors",
            \.version: "kMDItemVersion",
            \.comment: "kMDItemComment",
            \.starRating: "kMDItemStarRating",
            \.whereFroms: "kMDItemWhereFroms",
            \.finderComment: "kMDItemFinderComment",
            \.finderTags: "kMDItemUserTags",
            \.finderPrimaryTagColorIndex: "kMDItemFSLabel",
            \.primaryFinderTagColor: "kMDItemFSLabel",
            \.hasCustomIcon: "kMDItemFSHasCustomIcon",
            \.usageCount: "kMDItemUseCount",
            \.bundleIdentifier: "kMDItemCFBundleIdentifier",
            \.executableArchitectures: "kMDItemExecutableArchitectures",
            \.executablePlatform: "kMDItemExecutablePlatform",
            \.encodingApplications: "kMDItemEncodingApplications",
            \.applicationCategories: "kMDItemApplicationCategories",
            \.isApplicationManaged: "kMDItemIsApplicationManaged",
            \.appstoreCategory: "kMDItemAppStoreCategory",
            \.appstoreCategoryType: "kMDItemAppStoreCategoryType",

            // MARK: - Document

            \.textContent: "kMDItemTextContent",
            \.subject: "kMDItemSubject",
            \.theme: "kMDItemTheme",
            \.headline: "kMDItemHeadline",
            \.creator: "kMDItemCreator",
            \.instructions: "kMDItemInstructions",
            \.editors: "kMDItemEditors",
            \.audiences: "kMDItemAudiences",
            \.coverage: "kMDItemCoverage",
            \.projects: "kMDItemProjects",
            \.numberOfPages: "kMDItemNumberOfPages",
            \.pageWidth: "kMDItemPageWidth",
            \.pageHeight: "kMDItemPageHeight",
            \.copyright: "kMDItemCopyright",
            \.fonts: "kMDItemFonts",
            \.fontFamilyName: "com_apple_ats_name_family",
            \.contactKeywords: "kMDItemContactKeywords",
            \.languages: "kMDItemLanguages",
            \.rights: "kMDItemRights",
            \.organizations: "kMDItemOrganizations",
            \.publishers: "kMDItemPublishers",
            \.emailAddresses: "kMDItemEmailAddresses",
            \.phoneNumbers: "kMDItemPhoneNumbers",
            \.contributors: "kMDItemContributors",
            \.securityMethod: "kMDItemSecurityMethod",

            // MARK: - Places

            \.country: "kMDItemCountry",
            \.city: "kMDItemCity",
            \.stateOrProvince: "kMDItemStateOrProvince",
            \.areaInformation: "kMDItemGPSAreaInformation",
            \.namedLocation: "kMDItemNamedLocation",
            \.altitude: "kMDItemAltitude",
            \.latitude: "kMDItemLatitude",
            \.longitude: "kMDItemLongitude",
            \.speed: "kMDItemSpeed",
            \.timestamp: "kMDItemTimestamp",
            \.gpsTrack: "kMDItemGPSTrack",
            \.gpsStatus: "kMDItemGPSStatus",
            \.gpsMeasureMode: "kMDItemGPSMeasureMode",
            \.gpsDop: "kMDItemGPSDOP",
            \.gpsMapDatum: "kMDItemGPSMapDatum",
            \.gpsDestLatitude: "kMDItemGPSDestLatitude",
            \.gpsDestLongitude: "kMDItemGPSDestLongitude",
            \.gpsDestBearing: "kMDItemGPSDestBearing",
            \.gpsDestDistance: "kMDItemGPSDestDistance",
            \.gpsProcessingMethod: "kMDItemGPSProcessingMethod",
            \.gpsDateStamp: "kMDItemGPSDateStamp",
            \.gpsDifferental: "kMDItemGPSDifferental",

            // MARK: - Audio

            \.audioSampleRate: "kMDItemAudioSampleRate",
            \.audioChannelCount: "kMDItemAudioChannelCount",
            \.tempo: "kMDItemTempo",
            \.keySignature: "kMDItemSignature",
            \.timeSignature: "kMDItemTimeSignature",
            \.audioEncodingApplication: "kMDItemAudioEncodingApplication",
            \.trackNumber: "kMDItemAudioTrackNumber",
            \.composer: "kMDItemComposer",
            \.lyricist: "kMDItemLyricist",
            \.recordingDate: "kMDItemRecordingDate",
            \.recordingYear: "kMDItemRecordingYear",
            \.musicalGenre: "kMDItemMusicalGenre",
            \.isGeneralMidiSequence: "kMDItemIsGeneralMIDISequence",
            \.appleLoopsRootKey: "kMDItemAppleLoopsRootKey",
            \.appleLoopsKeyFilterType: "kMDItemAppleLoopsKeyFilterType",
            \.appleLoopsLoopMode: "kMDItemAppleLoopsLoopMode",
            \.appleLoopDescriptors: "kMDItemAppleLoopDescriptors",
            \.musicalInstrumentCategory: "kMDItemMusicalInstrumentCategory",
            \.musicalInstrumentName: "kMDItemMusicalInstrumentName",

            // MARK: - Media

            \.durationSeconds: "kMDItemDurationSeconds",
            \.duration: "kMDItemDurationSeconds",
            \.mediaTypes: "kMDItemMediaTypes",
            \.codecs: "kMDItemCodecs",
            \.totalBitRate: "kMDItemTotalBitRate",
            \.videoBitRate: "kMDItemVideoBitRate",
            \.audioBitRate: "kMDItemAudioBitRate",
            \.streamable: "kMDItemStreamable",
            \.mediaDeliveryType: "kMDItemDeliveryType",
            \.originalFormat: "kMDItemOriginalFormat",
            \.originalSource: "kMDItemOriginalSource",
            \.director: "kMDItemDirector",
            \.producer: "kMDItemProducer",
            \.genre: "kMDItemGenre",
            \.performers: "kMDItemPerformers",
            \.participants: "kMDItemParticipants",

            // MARK: - Image

            \.pixelHeight: "kMDItemPixelHeight",
            \.pixelWidth: "kMDItemPixelWidth",
            \.pixelSize: "kMDItemPixelSize",
            \.pixelCount: "kMDItemPixelCount",
            \.colorSpace: "kMDItemColorSpace",
            \.bitsPerSample: "kMDItemBitsPerSample",
            \.flashOnOff: "kMDItemFlashOnOff",
            \.focalLength: "kMDItemFocalLength",
            \.deviceManufacturer: "kMDItemAcquisitionMake",
            \.deviceModel: "kMDItemAcquisitionModel",
            \.isoSpeed: "kMDItemISOSpeed",
            \.orientation: "kMDItemOrientation",
            \.layerNames: "kMDItemLayerNames",
            \.aperture: "kMDItemAperture",
            \.colorProfile: "kMDItemProfileName",
            \.dpiResolutionWidth: "kMDItemResolutionWidthDPI",
            \.dpiResolutionHeight: "kMDItemResolutionHeightDPI",
            \.dpiResolution: "kMDItemResolutionSizeDPI",
            \.exposureMode: "kMDItemExposureMode",
            \.exposureTimeSeconds: "kMDItemExposureTimeSeconds",
            \.exifVersion: "kMDItemEXIFVersion",
            \.cameraOwner: "kMDItemCameraOwner",
            \.focalLength35Mm: "kMDItemFocalLength35mm",
            \.lensModel: "kMDItemLensModel",
            \.imageDirection: "kMDItemImageDirection",
            \.hasAlphaChannel: "kMDItemHasAlphaChannel",
            \.redEyeOnOff: "kMDItemRedEyeOnOff",
            \.meteringMode: "kMDItemMeteringMode",
            \.maxAperture: "kMDItemMaxAperture",
            \.fNumber: "kMDItemFNumber",
            \.exposureProgram: "kMDItemExposureProgram",
            \.exposureTimeString: "kMDItemExposureTimeString",
            \.isScreenCapture: "kMDItemIsScreenCapture",
            \.screenCaptureRect: "kMDItemScreenCaptureGlobalRect",
            \.screenCaptureType: "kMDItemScreenCaptureType",

            // MARK: - Messages / Mail

            \.authorEmailAddresses: "kMDItemAuthorEmailAddresses",
            \.authorAddresses: "kMDItemAuthorAddresses",
            \.recipients: "kMDItemRecipients",
            \.recipientEmailAddresses: "kMDItemRecipientEmailAddresses",
            \.recipientAddresses: "kMDItemRecipientAddresses",
            \.instantMessageAddresses: "kMDItemInstantMessageAddresses",
            \.receivedDates: "kMDItemUserSharedReceivedDate",
            \.receivedRecipients: "kMDItemUserSharedReceivedRecipient",
            \.receivedRecipientHandles: "kMDItemUserSharedReceivedRecipientHandle",
            \.receivedSenders: "kMDItemUserSharedReceivedSender",
            \.receivedSenderHandles: "kMDItemUserSharedReceivedSenderHandle",
            \.receivedTypes: "kMDItemUserSharedReceivedTransport",
            \.isLikelyJunk: "kMDItemIsLikelyJunk",

            \.queryContentRelevance: "kMDQueryResultContentRelevance",
        ]
}

extension PartialKeyPath where Root == MetadataItem {
    var mdItemKey: String {
        MetadataItem.attributeKeys[self] ?? "kMDItemFSName"
    }
}
