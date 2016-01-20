import PackageDescription

let package = Package(
    name: "Queue",
    testDependencies: [
        .Package(url: "https://github.com/kylef/spectre-build.git", majorVersion: 0),
    ]
)
