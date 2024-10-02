import exif

extension ExifTag: @retroactive CustomStringConvertible {
	public static let interoperabilityIndex = ExifTag(0x0001)
	public static let interoperabilityVersion = ExifTag(0x0002)
	public static let newSubfileType = ExifTag(0x00fe)
	public static let imageWidth = ExifTag(0x0100)
	public static let imageLength = ExifTag(0x0101)
	public static let bitsPerSample = ExifTag(0x0102)
	public static let compression = ExifTag(0x0103)
	public static let photometricInterpretation = ExifTag(0x0106)
	public static let fillOrder = ExifTag(0x010a)
	public static let documentName = ExifTag(0x010d)
	public static let imageDescription = ExifTag(0x010e)
	public static let make = ExifTag(0x010f)
	public static let model = ExifTag(0x0110)
	public static let stripOffsets = ExifTag(0x0111)
	public static let orientation = ExifTag(0x0112)
	public static let samplesPerPixel = ExifTag(0x0115)
	public static let rowsPerStrip = ExifTag(0x0116)
	public static let stripByteCounts = ExifTag(0x0117)
	public static let xResolution = ExifTag(0x011a)
	public static let yResolution = ExifTag(0x011b)
	public static let planarConfiguration = ExifTag(0x011c)
	public static let resolutionUnit = ExifTag(0x0128)
	public static let transferFunction = ExifTag(0x012d)
	public static let software = ExifTag(0x0131)
	public static let dateTime = ExifTag(0x0132)
	public static let artist = ExifTag(0x013b)
	public static let whitePoint = ExifTag(0x013e)
	public static let primaryChromaticities = ExifTag(0x013f)
	public static let subIfds = ExifTag(0x014a)
	public static let transferRange = ExifTag(0x0156)
	public static let jpegProc = ExifTag(0x0200)
	public static let jpegInterchangeFormat = ExifTag(0x0201)
	public static let jpegInterchangeFormatLength = ExifTag(0x0202)
	public static let ycbcrCoefficients = ExifTag(0x0211)
	public static let ycbcrSubSampling = ExifTag(0x0212)
	public static let ycbcrPositioning = ExifTag(0x0213)
	public static let referenceBlackWhite = ExifTag(0x0214)
	public static let xmlPacket = ExifTag(0x02bc)
	public static let relatedImageFileFormat = ExifTag(0x1000)
	public static let relatedImageWidth = ExifTag(0x1001)
	public static let relatedImageLength = ExifTag(0x1002)
	public static let imageDepth = ExifTag(0x80e5)
	public static let cfaRepeatPatternDim = ExifTag(0x828d)
	public static let cfaPattern = ExifTag(0x828e)
	public static let batteryLevel = ExifTag(0x828f)
	public static let copyright = ExifTag(0x8298)
	public static let exposureTime = ExifTag(0x829a)
	public static let fnumber = ExifTag(0x829d)
	public static let iptcNaa = ExifTag(0x83bb)
	public static let imageResources = ExifTag(0x8649)
	public static let exifIfdPointer = ExifTag(0x8769)
	public static let interColorProfile = ExifTag(0x8773)
	public static let exposureProgram = ExifTag(0x8822)
	public static let spectralSensitivity = ExifTag(0x8824)
	public static let gpsInfoIfdPointer = ExifTag(0x8825)
	public static let isoSpeedRatings = ExifTag(0x8827)
	public static let oecf = ExifTag(0x8828)
	public static let timeZoneOffset = ExifTag(0x882a)
	public static let sensitivityType = ExifTag(0x8830)
	public static let standardOutputSensitivity = ExifTag(0x8831)
	public static let recommendedExposureIndex = ExifTag(0x8832)
	public static let isoSpeed = ExifTag(0x8833)
	public static let latitudeYYY = ExifTag(0x8834)
	public static let latitudeZZZ = ExifTag(0x8835)
	public static let exifVersion = ExifTag(0x9000)
	public static let dateTimeOriginal = ExifTag(0x9003)
	public static let dateTimeDigitized = ExifTag(0x9004)
	public static let offsetTime = ExifTag(0x9010)
	public static let offsetTimeOriginal = ExifTag(0x9011)
	public static let offsetTimeDigitized = ExifTag(0x9012)
	public static let componentsConfiguration = ExifTag(0x9101)
	public static let compressedBitsPerPixel = ExifTag(0x9102)
	public static let shutterSpeedValue = ExifTag(0x9201)
	public static let apertureValue = ExifTag(0x9202)
	public static let brightnessValue = ExifTag(0x9203)
	public static let exposureBiasValue = ExifTag(0x9204)
	public static let maxApertureValue = ExifTag(0x9205)
	public static let subjectDistance = ExifTag(0x9206)
	public static let meteringMode = ExifTag(0x9207)
	public static let lightSource = ExifTag(0x9208)
	public static let flash = ExifTag(0x9209)
	public static let focalLength = ExifTag(0x920a)
	public static let subjectArea = ExifTag(0x9214)
	public static let tiffEpStandardId = ExifTag(0x9216)
	public static let makerNote = ExifTag(0x927c)
	public static let userComment = ExifTag(0x9286)
	public static let subSecTime = ExifTag(0x9290)
	public static let subSecTimeOriginal = ExifTag(0x9291)
	public static let subSecTimeDigitized = ExifTag(0x9292)
	public static let xpTitle = ExifTag(0x9c9b)
	public static let xpComment = ExifTag(0x9c9c)
	public static let xpAuthor = ExifTag(0x9c9d)
	public static let xpKeywords = ExifTag(0x9c9e)
	public static let xpSubject = ExifTag(0x9c9f)
	public static let flashPixVersion = ExifTag(0xa000)
	public static let colorSpace = ExifTag(0xa001)
	public static let pixelXDimension = ExifTag(0xa002)
	public static let pixelYDimension = ExifTag(0xa003)
	public static let relatedSoundFile = ExifTag(0xa004)
	public static let interoperabilityIfdPointer = ExifTag(0xa005)
	public static let flashEnergy = ExifTag(0xa20b)
	public static let spatialFrequencyResponse = ExifTag(0xa20c)
	public static let focalPlaneXResolution = ExifTag(0xa20e)
	public static let focalPlaneYResolution = ExifTag(0xa20f)
	public static let focalPlaneResolutionUnit = ExifTag(0xa210)
	public static let subjectLocation = ExifTag(0xa214)
	public static let exposureIndex = ExifTag(0xa215)
	public static let sensingMethod = ExifTag(0xa217)
	public static let fileSource = ExifTag(0xa300)
	public static let sceneType = ExifTag(0xa301)
	public static let newCfaPattern = ExifTag(0xa302)
	public static let customRendered = ExifTag(0xa401)
	public static let exposureMode = ExifTag(0xa402)
	public static let whiteBalance = ExifTag(0xa403)
	public static let digitalZoomRatio = ExifTag(0xa404)
	public static let focalLengthIn35MmFilm = ExifTag(0xa405)
	public static let sceneCaptureType = ExifTag(0xa406)
	public static let gainControl = ExifTag(0xa407)
	public static let contrast = ExifTag(0xa408)
	public static let saturation = ExifTag(0xa409)
	public static let sharpness = ExifTag(0xa40a)
	public static let deviceSettingDescription = ExifTag(0xa40b)
	public static let subjectDistanceRange = ExifTag(0xa40c)
	public static let imageUniqueId = ExifTag(0xa420)
	public static let cameraOwnerName = ExifTag(0xa430)
	public static let bodySerialNumber = ExifTag(0xa431)
	public static let lensSpecification = ExifTag(0xa432)
	public static let lensMake = ExifTag(0xa433)
	public static let lensModel = ExifTag(0xa434)
	public static let lensSerialNumber = ExifTag(0xa435)
	public static let compositeImage = ExifTag(0xa460)
	public static let sourceImageNumberOfCompositeImage = ExifTag(0xa461)
	public static let sourceExposureTimesOfCompositeImage = ExifTag(0xa462)
	public static let gamma = ExifTag(0xa500)
	public static let printImageMatching = ExifTag(0xc4a5)
	public static let padding = ExifTag(0xea1c)


	public static let gpsVersionId = ExifTag(0x0000)
	public static let gpsLatitudeRef = ExifTag(0x0001)
	public static let gpsLatitude = ExifTag(0x0002)
	public static let gpsLongitudeRef = ExifTag(0x0003)
	public static let gpsLongitude = ExifTag(0x0004)
	public static let gpsAltitudeRef = ExifTag(0x0005)
	public static let gpsAltitude = ExifTag(0x0006)
	public static let gpsTimeStamp = ExifTag(0x0007)
	public static let gpsSatellites = ExifTag(0x0008)
	public static let gpsStatus = ExifTag(0x0009)
	public static let gpsMeasureMode = ExifTag(0x000a)
	public static let gpsDop = ExifTag(0x000b)
	public static let gpsSpeedRef = ExifTag(0x000c)
	public static let gpsSpeed = ExifTag(0x000d)
	public static let gpsTrackRef = ExifTag(0x000e)
	public static let gpsTrack = ExifTag(0x000f)
	public static let gpsImgDirectionRef = ExifTag(0x0010)
	public static let gpsImgDirection = ExifTag(0x0011)
	public static let gpsMapDatum = ExifTag(0x0012)
	public static let gpsDestLatitudeRef = ExifTag(0x0013)
	public static let gpsDestLatitude = ExifTag(0x0014)
	public static let gpsDestLongitudeRef = ExifTag(0x0015)
	public static let gpsDestLongitude = ExifTag(0x0016)
	public static let gpsDestBearingRef = ExifTag(0x0017)
	public static let gpsDestBearing = ExifTag(0x0018)
	public static let gpsDestDistanceRef = ExifTag(0x0019)
	public static let gpsDestDistance = ExifTag(0x001a)
	public static let gpsProcessingMethod = ExifTag(0x001b)
	public static let gpsAreaInformation = ExifTag(0x001c)
	public static let gpsDateStamp = ExifTag(0x001d)
	public static let gpsDifferential = ExifTag(0x001e)
	public static let gpsHPositioningError = ExifTag(0x001f)

	public var description: String {
		switch self.rawValue {
		case 0x0001: "exifTagInteroperabilityIndex"
		case 0x0002: "exifTagInteroperabilityVersion"
		case 0x00fe: "exifTagNewSubfileType"
		case 0x0100: "exifTagImageWidth"
		case 0x0101: "exifTagImageLength"
		case 0x0102: "exifTagBitsPerSample"
		case 0x0103: "exifTagCompression"
		case 0x0106: "exifTagPhotometricInterpretation"
		case 0x010a: "exifTagFillOrder"
		case 0x010d: "exifTagDocumentName"
		case 0x010e: "exifTagImageDescription"
		case 0x010f: "exifTagMake"
		case 0x0110: "exifTagModel"
		case 0x0111: "exifTagStripOffsets"
		case 0x0112: "exifTagOrientation"
		case 0x0115: "exifTagSamplesPerPixel"
		case 0x0116: "exifTagRowsPerStrip"
		case 0x0117: "exifTagStripByteCounts"
		case 0x011a: "exifTagXResolution"
		case 0x011b: "exifTagYResolution"
		case 0x011c: "exifTagPlanarConfiguration"
		case 0x0128: "exifTagResolutionUnit"
		case 0x012d: "exifTagTransferFunction"
		case 0x0131: "exifTagSoftware"
		case 0x0132: "exifTagDateTime"
		case 0x013b: "exifTagArtist"
		case 0x013e: "exifTagWhitePoint"
		case 0x013f: "exifTagPrimaryChromaticities"
		case 0x014a: "exifTagSubIfds"
		case 0x0156: "exifTagTransferRange"
		case 0x0200: "exifTagJpegProc"
		case 0x0201: "exifTagJpegInterchangeFormat"
		case 0x0202: "exifTagJpegInterchangeFormatLength"
		case 0x0211: "exifTagYcbcrCoefficients"
		case 0x0212: "exifTagYcbcrSubSampling"
		case 0x0213: "exifTagYcbcrPositioning"
		case 0x0214: "exifTagReferenceBlackWhite"
		case 0x02bc: "exifTagXmlPacket"
		case 0x1000: "exifTagRelatedImageFileFormat"
		case 0x1001: "exifTagRelatedImageWidth"
		case 0x1002: "exifTagRelatedImageLength"
		case 0x80e5: "exifTagImageDepth"
		case 0x828d: "exifTagCfaRepeatPatternDim"
		case 0x828e: "exifTagCfaPattern"
		case 0x828f: "exifTagBatteryLevel"
		case 0x8298: "exifTagCopyright"
		case 0x829a: "exifTagExposureTime"
		case 0x829d: "exifTagFnumber"
		case 0x83bb: "exifTagIptcNaa"
		case 0x8649: "exifTagImageResources"
		case 0x8769: "exifTagExifIfdPointer"
		case 0x8773: "exifTagInterColorProfile"
		case 0x8822: "exifTagExposureProgram"
		case 0x8824: "exifTagSpectralSensitivity"
		case 0x8825: "exifTagGpsInfoIfdPointer"
		case 0x8827: "exifTagIsoSpeedRatings"
		case 0x8828: "exifTagOecf"
		case 0x882a: "exifTagTimeZoneOffset"
		case 0x8830: "exifTagSensitivityType"
		case 0x8831: "exifTagStandardOutputSensitivity"
		case 0x8832: "exifTagRecommendedExposureIndex"
		case 0x8833: "exifTagIsoSpeed"
		case 0x8834: "exifTAGISOSPEEDLatitudeYYY"
		case 0x8835: "exifTAGISOSPEEDLatitudeZZZ"
		case 0x9000: "exifTagExifVersion"
		case 0x9003: "exifTagDateTimeOriginal"
		case 0x9004: "exifTagDateTimeDigitized"
		case 0x9010: "exifTagOffsetTime"
		case 0x9011: "exifTagOffsetTimeOriginal"
		case 0x9012: "exifTagOffsetTimeDigitized"
		case 0x9101: "exifTagComponentsConfiguration"
		case 0x9102: "exifTagCompressedBitsPerPixel"
		case 0x9201: "exifTagShutterSpeedValue"
		case 0x9202: "exifTagApertureValue"
		case 0x9203: "exifTagBrightnessValue"
		case 0x9204: "exifTagExposureBiasValue"
		case 0x9205: "exifTagMaxApertureValue"
		case 0x9206: "exifTagSubjectDistance"
		case 0x9207: "exifTagMeteringMode"
		case 0x9208: "exifTagLightSource"
		case 0x9209: "exifTagFlash"
		case 0x920a: "exifTagFocalLength"
		case 0x9214: "exifTagSubjectArea"
		case 0x9216: "exifTagTiffEpStandardId"
		case 0x927c: "exifTagMakerNote"
		case 0x9286: "exifTagUserComment"
		case 0x9290: "exifTagSubSecTime"
		case 0x9291: "exifTagSubSecTimeOriginal"
		case 0x9292: "exifTagSubSecTimeDigitized"
		case 0x9c9b: "exifTagXpTitle"
		case 0x9c9c: "exifTagXpComment"
		case 0x9c9d: "exifTagXpAuthor"
		case 0x9c9e: "exifTagXpKeywords"
		case 0x9c9f: "exifTagXpSubject"
		case 0xa000: "exifTagFlashPixVersion"
		case 0xa001: "exifTagColorSpace"
		case 0xa002: "exifTagPixelXDimension"
		case 0xa003: "exifTagPixelYDimension"
		case 0xa004: "exifTagRelatedSoundFile"
		case 0xa005: "exifTagInteroperabilityIfdPointer"
		case 0xa20b: "exifTagFlashEnergy"
		case 0xa20c: "exifTagSpatialFrequencyResponse"
		case 0xa20e: "exifTagFocalPlaneXResolution"
		case 0xa20f: "exifTagFocalPlaneYResolution"
		case 0xa210: "exifTagFocalPlaneResolutionUnit"
		case 0xa214: "exifTagSubjectLocation"
		case 0xa215: "exifTagExposureIndex"
		case 0xa217: "exifTagSensingMethod"
		case 0xa300: "exifTagFileSource"
		case 0xa301: "exifTagSceneType"
		case 0xa302: "exifTagNewCfaPattern"
		case 0xa401: "exifTagCustomRendered"
		case 0xa402: "exifTagExposureMode"
		case 0xa403: "exifTagWhiteBalance"
		case 0xa404: "exifTagDigitalZoomRatio"
		case 0xa405: "exifTagFocalLengthIn35MmFilm"
		case 0xa406: "exifTagSceneCaptureType"
		case 0xa407: "exifTagGainControl"
		case 0xa408: "exifTagContrast"
		case 0xa409: "exifTagSaturation"
		case 0xa40a: "exifTagSharpness"
		case 0xa40b: "exifTagDeviceSettingDescription"
		case 0xa40c: "exifTagSubjectDistanceRange"
		case 0xa420: "exifTagImageUniqueId"
		case 0xa430: "exifTagCameraOwnerName"
		case 0xa431: "exifTagBodySerialNumber"
		case 0xa432: "exifTagLensSpecification"
		case 0xa433: "exifTagLensMake"
		case 0xa434: "exifTagLensModel"
		case 0xa435: "exifTagLensSerialNumber"
		case 0xa460: "exifTagCompositeImage"
		case 0xa461: "exifTagSourceImageNumberOfCompositeImage"
		case 0xa462: "exifTagSourceExposureTimesOfCompositeImage"
		case 0xa500: "exifTagGamma"
		case 0xc4a5: "exifTagPrintImageMatching"
		case 0xea1c: "exifTagPadding"
		default: "exifTagUnknown"
		}
	}
}

extension ExifTag: @retroactive Equatable {}
extension ExifTag: @retroactive Hashable {}
