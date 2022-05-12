# GCLOG SWIFT
Log shareable cURL to Developer Console, to Messenging Program (e.g. Telegram, Slack), and more (https://getcurl.app)

## How it works
<img width="786" alt="gc_logger_flow" src="https://user-images.githubusercontent.com/4256921/167043591-8d7e28d6-ed25-4ad8-9af3-26f1df72c286.png">

## Features

✅ Log cURL as a GETCURL link to Developer Console

✅ Log URLRequest as a GETCURL link to Developer Console

☑️ Log GETCURL link to Telegram

## Installation

### Swift Package Manager
The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

 ```
 dependencies: [
    .package(url: "https://github.com/docsion/GcLogSwift.git", .upToNextMajor(from: "1.0"))
]
```


### Cocoapods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Swift and Objective-C Cocoa projects. It has over 89 thousand libraries and is used in over 3 million apps. CocoaPods can help you scale your projects elegantly.

 ```
pod 'GcLog'
```


## Using GcLog

### Log cURL

 ```
 GC.log(any: "curl 'https://mocha.lozi.vn/v6/search/eateries/promoted?cityId=50&limit=12&page=1&superCategoryId=1&lat=10.7765194&lng=106.700987' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:99.0) Gecko/20100101 Firefox/99.0' -H 'Accept: */*' -H 'Accept-Language: vi_VN' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Access-Token: unknown' -H 'X-City-ID: 50' -H 'X-Lozi-Client: 1' -H 'Origin: https://loship.vn' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Referer: https://loship.vn/' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: cross-site' -H 'TE: trailers'")

```

>https://getcurl.app/#body=Y3VybCAnaHR0cHM6Ly9tb2NoYS5sb3ppLnZuL3Y2L3NlYXJjaC9lYXRlcmllcy9wcm9tb3RlZD9jaXR5SWQ9NTAmbGltaXQ9MTImcGFnZT0xJnN1cGVyQ2F0ZWdvcnlJZD0xJmxhdD0xMC43NzY1MTk0JmxuZz0xMDYuNzAwOTg3JyAtSCAnVXNlci1BZ2VudDogTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTAuMTU7IHJ2Ojk5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvOTkuMCcgLUggJ0FjY2VwdDogKi8qJyAtSCAnQWNjZXB0LUxhbmd1YWdlOiB2aV9WTicgLUggJ0FjY2VwdC1FbmNvZGluZzogZ3ppcCwgZGVmbGF0ZSwgYnInIC1IICdYLUFjY2Vzcy1Ub2tlbjogdW5rbm93bicgLUggJ1gtQ2l0eS1JRDogNTAnIC1IICdYLUxvemktQ2xpZW50OiAxJyAtSCAnT3JpZ2luOiBodHRwczovL2xvc2hpcC52bicgLUggJ0ROVDogMScgLUggJ0Nvbm5lY3Rpb246IGtlZXAtYWxpdmUnIC1IICdSZWZlcmVyOiBodHRwczovL2xvc2hpcC52bi8nIC1IICdTZWMtRmV0Y2gtRGVzdDogZW1wdHknIC1IICdTZWMtRmV0Y2gtTW9kZTogY29ycycgLUggJ1NlYy1GZXRjaC1TaXRlOiBjcm9zcy1zaXRlJyAtSCAnVEU6IHRyYWlsZXJzJw==

### Log URLRequest
 ```
 guard let url = URL(string: "https://mocha.lozi.vn/v6/search/eateries/promoted?cityId=50") else { return }
 let request = URLRequest(url: url)

 // HERE WE LOG
 GC.use(logParser: URLRequestLogParser()) // Set once
 GC.log(any: request) // log many
```
>https://getcurl.app/#body=Y3VybCAnaHR0cHM6Ly9tb2NoYS5sb3ppLnZuL3Y2L3NlYXJjaC9lYXRlcmllcy9wcm9tb3RlZD9jaXR5SWQ9NTAnIC1YIEdFVA==

## More languages
[Swift, Kotlin, Javascript and 99+ programing languages are supported.](https://github.com/docsion/gclog)


## Contact
https://getcurl.app/hello
