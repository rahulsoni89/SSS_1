import PackageDescription

let package = Package(
    name: "test1",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2)
    ]
)
