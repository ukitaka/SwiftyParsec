import PackageDescription

let package = Package(
    name: "SwiftyParsec",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/thoughtbot/Runes.git",
            majorVersion: 4)
    ]
)
