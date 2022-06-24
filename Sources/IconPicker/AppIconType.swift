//
//  AppIconType.swift
//  IconPicker
//

#if os(iOS)

import UIKit

public protocol AppIconType: CaseIterable, RawRepresentable, Equatable
where AllCases.Index == Int, RawValue == String {}

extension AppIconType {
	func partialIndex() -> Int {
		Self.allCases.firstIndex(of: self)!
	}

	static func current() -> Self? {
		guard let iconName = UIApplication.shared.alternateIconName else { return nil }
		return Self(rawValue: iconName)
	}
}

extension AppIconType {
	static func currentIndex() -> Int {
		return 1 + (Self.current()?.partialIndex() ?? -1)
	}

	static func setCurrentIndex(_ index: Int, completionHandler completion: ((Error?) -> Void)? = nil) {
		if index == 0 {
			UIApplication.shared.setAlternateIconName(nil, completionHandler: completion)
		} else {
			UIApplication.shared.setAlternateIconName(Self.allCases[index - 1].rawValue, completionHandler: completion)
		}
	}
}

extension AppIconType {
	public static func currentImage() -> UIImage {
		return Self.imageFrom(index: Self.currentIndex())
	}

	static func imageFrom(index: Int) -> UIImage {
		if index == 0 {
			return UIImage(named: "thumbnail-AppIcon")!
		} else {
			return UIImage(named: "thumbnail-\(Self.allCases[index - 1].rawValue)")!
		}
	}
}

#endif
