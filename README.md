# BRCache

A typesafe key-value cache for iOS, iPadOS, macOS, tvOS and watchOS written in Swift.

- Link caches with different key and value types.
- Protocol based API. Create and combine caches as needed.
- Clean, single-purpose implementation. Does caching and nothing else.

## Installation

### Swift Package Manager

Add to project in Xcode. In the file navigator select your project and then the "Swift Packages" tab. Press the "+" button and add the project url.

### CocoaPods

```
Add to Podfile:
pod 'BRCache', :git => 'https://github.com/BjornRuud/BRCache.git'

For a specific branch:
pod 'BRCache', :git => 'https://github.com/BjornRuud/BRCache.git', :branch => 'master'

For a specific tag, like a release:
pod 'BRCache', :git => 'https://github.com/BjornRuud/BRCache.git', :tag => '1.0.0'

Then:
$ pod install
```

### Manual

Clone the repo somewhere suitable, like inside your project repo so BRCache can be added as a subrepo, then drag `BRCache.xcodeproj` into your project.

Alternatively build the framework and add it to your project.

## Usage

### Simple Memory Cache

```swift
let cache = MemoryCache<String, String>()
let key = "foo"
let text = "bar"
try cache.setValue(text, forKey: key)
let cachedText = try cache.value(forKey: key)
```

Different caches use different kinds of storage. Caches using memory and the file system are included. Implement the `CacheAPI` protocol in order to create your own cache.

### Linking Caches

Caches can be linked to provide cache layers with the `CombinedCache`. This cache also implements the `CacheAPI` protocol and can be combined, linking as many layers as are needed. There is no automatic propagation of changes between primary and secondary caches with one exception; querying a primary cache for a value or attributes for a value will query the secondary cache if the value is not found, and the primary cache will be updated with the value from the secondary if it exists. The keys and values do not have to be the same for the linked caches since you provide transforms to make them compatible.

Here is an example of a filesystem cache with a memory cache in front, where the keys and values are the same type:

```swift
struct Book: Codable {
    let title: String
}

let cache = CombinedCache(
    primary: MemoryCache<String, Book>(),
    secondary: try! FileSystemCache<String, Book>(),
    keyTransform: { $0 },
    primaryValueTransform: { $0 },
    secondaryValueTransform: { $0 }
)

let book = Book(title: "Foundation")
try cache.setValue(book, forKey: "asimov")
if let foundBook = try cache.value(forKey: "asimov") {
	// ...
}
```

A more advanced example with key and value transforms:

```swift
let cache = CombinedCache(
    primary: MemoryCache<String, Book>(),
    secondary: try FileSystemCache<Int, Data>(),
    keyTransform: { Int($0) },
    primaryValueTransform: { try! JSONEncoder().encode($0) },
    secondaryValueTransform: { try! JSONDecoder().decode(Book.self, from: $0) }
)

let dataKey = 42
let memoryKey = "42"
let book = Book(title: "foo")
let bookData = try JSONEncoder().encode(book)

cache.secondaryCache.setValue(bookData, forKey: dataKey)
let fetchedBook = try cache.value(forKey: memoryKey)
```
