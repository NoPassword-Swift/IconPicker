// swift-tools-version:5.0

import PackageDescription

let package = Package(
	name: "IconPicker",
	platforms: [
		.iOS("13.0"),
		.macOS("12.0"),
	],
	products: [
		.library(
			name: "IconPicker",
			targets: ["IconPicker"]),
	],
	dependencies: [
		.package(url: "https://github.com/NoPassword-Swift/ConstraintKit.git", "0.0.1"..<"0.1.0"),
		.package(url: "https://github.com/NoPassword-Swift/NPKit.git", "0.0.1"..<"0.1.0"),
	],
	targets: [
		.target(
			name: "IconPicker",
			dependencies: [
				"ConstraintKit",
				"NPKit",
			]),
	]
)
