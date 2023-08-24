## Using Uber H3 cells with Swift/iOS

<img src="https://github.com/ehmjaysee/h3-ios/blob/master/assets/h3.png" />

## What is H3?

Uber maintains an open source library called H3 which they use in their mobile apps. H3 is based on the concept of dividing the surface of the planet into a grid of hexigons or 'cells'. Each call has a unique identifier and a fixed size and location. This type of grid system is much more powerful than a simple grid of latitude/longitude which produces a set of 'rectangles'. The H3 code library can be used in various ways:

- Given a latitude/longitude point, find the index of the containing H3 cell
- Given an H3 index, find the latitude/longitude cell center
- Given an H3 index, determine the cell boundary in latitude/longitude coordinates
- Find the coordinates of the 6 points for any cell
- Find the distance from a point to the cell edge

Furthermore, H3 defines more than one grid size for the planet. In fact H3 defines 16 distince 'resolutions' ranging from 0.0000009 km^2 up to 4,250,546.8477000 km^2. There is a parent/child relationship between two cells at adjacent resolutions.

Read more about the H3 grid system here: https://h3geo.org

## Getting Started

H3kit primarily uses [SwiftPM](https://swift.org/package-manager/) as its build tool, so we recommend using that as well. If you want to depend on H3kit in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dividenconquer/h3kit-ios.git", from: "1.0.0")
]
```

### Using Xcode Package support

If your project is set up as an Xcode project and you're using Xcode 11+, you can add H3Kit as a dependency to your
Xcode project by clicking File -> Swift Packages -> Add Package Dependency. In the upcoming dialog, please enter
`https://github.com/dividenconquer/h3kit-ios.git` and click Next twice.

## Usage with Swift

```swift
import H3kit

func testH3() {
    let latitude = 40.1234
    let longitude = 98.5432
    let resolution: Int32 = 14
    let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let index = point.h3CellIndex(resolution: resolution)
    let hex = String(index, radix: 16, uppercase: true)
    print(hex)

    let neighbors = point.h3Neighbors(resolution: resolution, ringLevel: 1)
    for item in neighbors {
        print(String(item, radix: 16, uppercase: true))
    }
}
```

## Usage with C interface

The C librarary has a rich set of APIs documented here: https://h3geo.org/docs/api/indexing
You can access the entire API from your Swift based project. Here are some of the main functions:

```C
H3Index geoToH3(const GeoCoord *g, int res);
void h3ToGeo(H3Index h3, GeoCoord *g);
void h3ToGeoBoundary(H3Index h3, GeoBoundary *gp);
void kRing(H3Index origin, int k, H3Index* out);
int maxKringSize(int k);
h3Line
```

Example showing how to take a set of 2D coordinates and generate the set of cells sourrounding that position.

```c
// Determine the set of nearby H3 cells based on location
let latitude = degsToRads( 41.3343 )   // MUST convert to radians
let longitude = degsToRads( 101.1188 )
var location = GeoCoord(lat: latitude, lon: longitude)
let index = geoToH3(&location, 6)
let count = Int(maxKringSize(1))
var neighbors = Array(repeating: H3Index(), count: count)
kRing(index, 1, &neighbors);
```

## License

MIT License

Copyright (c) 2023 Hakko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
