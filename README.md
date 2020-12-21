# EveryDayCodeBlocks

Dont repeat your self every day.
Feel free to copy pase what you need, If you need too much you could use it as a pod.
<p align="left">
  <img src="" title="EveryDayBlocks">
</p>
</p>
 <p align="center">
<img src="https://img.shields.io/github/workflow/status/abuzeid-ibrahim/MimiMusicPlayer/iOS%20starter%20workflow/master">
<a href="https://developer.apple.com/swift/"><img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift"/></a>
<img src="https://img.shields.io/badge/Platform-iOS%2011.0+-lightgrey.svg" alt="Platform: iOS">
<img src="https://img.shields.io/badge/XCode-11.5%2B-lightgrey">
<img src="https://img.shields.io/badge/Code%20Coverage-71%25-brightgreen">
 <img src="https://img.shields.io/badge/Swift-5.0-orange.svg">
 <img src="https://img.shields.io/badge/Xcode-11.4-blue.svg">
 <img src="https://img.shields.io/badge/License-MIT-red.svg">
</p>

EveryDayCodeBlocks is a collection of **over 20 native Swift extensions and component**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 20 in 1– for iOS

## Requirements

- **iOS** 10.0+ 
- Swift 5.0+

## Installation

<details>
<summary>CocoaPods</summary>
</br>
<p>To integrate EveryDayCodeBlocks into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>

<h4>- Integrate All extensions (recommended):</h4>
<pre><code class="ruby language-ruby">pod 'EveryDayCodeBlocks'</code></pre>

<h4>- Integrate Network Layer extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'EveryDayCodeBlocks/DevNetwork'</code></pre>

<h4>- Integrate Foundation/UIKit extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'EveryDayCodeBlocks/DevNetwork'</code></pre>

<h4>- Integrate UIComponents only:</h4>
<pre><code class="ruby language-ruby">pod 'EveryDayCodeBlocks/UIComponents'</code></pre>

<h4>- Integrate Proxies and Wrappers extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'EveryDayCodeBlocks/Wrappers'</code></pre>
</details>

<details>
<summary>Swift Package Manager</summary>
</br>
<p>You can use <a href="https://swift.org/package-manager">The Swift Package Manager</a> to install <code>EveryDayCodeBlocks</code> by adding the proper description to your <code>Package.swift</code> file:</p>

<pre><code class="swift language-swift">import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks.git", from: "5.2.0")
    ]
)
</code></pre>

<p>Next, add <code>EveryDayCodeBlocks</code> to your targets dependencies like so:</p>
<pre><code class="swift language-swift">.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "EveryDayCodeBlocks",
    ]
),</code></pre>
<p>Then run <code>swift package update</code>.</p>

<p>Note that the <a href="https://swift.org/package-manager">Swift Package Manager</a> doesn't support building for iOS/tvOS/macOS/watchOS apps – see Accio in the next section for that.
</details>



<details>
<summary>Manually</summary>
</br>
<p>Add the <a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks">EveryDayCodeBlocks</a> folder to your Xcode project to use all extensions, or a specific extension.</p>
<p>For your test targets you can also add the <a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Tests/XCTest">XCTest</a> folder.</p>
</details>

## List of All Components

<details>
<summary> Components and Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks/SwiftStdlib/ArrayExtensions.swift"><code>Array extensions</code></a></li>
<li><a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks/SwiftStdlib/BidirectionalCollectionExtensions.swift"><code>Foundation and UIKit extensions</code></a></li>
<li><a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks/SwiftStdlib/BinaryFloatingPointExtensions.swift"><code>AudioPlayer Component</code></a></li>
<li><a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks/SwiftStdlib/BoolExtensions.swift"><code>Network</code></a></li>
<li><a href="https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/Sources/EveryDayCodeBlocks/SwiftStdlib/CharacterExtensions.swift"><code> extensions</code></a></li>
</ul>
</details>


## How cool is this?

EveryDayCodeBlocks is a library of **over 200 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original Swift API design guidelines.

Check Examples.playground from the project for some cool examples!

## Get involved

We want your feedback.
Please refer to [contributing guidelines](https://github.com/EveryDayCodeBlocks/EveryDayCodeBlocks/tree/master/CONTRIBUTING.md) before participating.

