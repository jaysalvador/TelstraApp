# Telstra App

Demo App for Telstra

<p align="left">
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/01.png" width="150" height="325" alt="accessibility text">
  
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/06.jpg" width="150" height="325" alt="accessibility text">
  <br />
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/03.jpg" width="250" height="325" alt="accessibility text">
  
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/04.jpg" width="400" height="325" alt="accessibility text">
  <br /> 
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/02.jpg" width="350" alt="accessibility text">
  
  <img src="https://github.com/jaysalvador/TelstraApp/blob/master/images/05.jpg" width="350" alt="accessibility text">
</p>

## TelstraAPI

Created a static library `TelstraAPI` that handles data retrieval and serialisation of data.

Implemented `HttpClient` class to handle HTTP requests to the API and decodes the response to any `Decodable` type object.

All API responses will be conforming to this closure, using the `Result` type:
>  `HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)`

`T` would need to conform to `Decodable` protocol, and errors will be extended using the `HttpError` enum states

## Client-side App

The app architecture is built using the MVVM pattern and Protocol-oriented programming and Dependency Injection principles.

### Cocoapods Dependency

- [Dwifft](https://github.com/jflinter/Dwifft) 
  - library has been used in this project to handle `UICollectionView` reloading and refreshing. `Section` and `Item` types are provided to define the `UICollectionView` sections and items, and must adhere to `Equatable` protocol. These types will be used within the `Dwifft` library to easily compare and reload the collection and its cells.
  - `JCollectionViewController` 
     - is class that extends `UIViewController` and implements `UICollectionView` delegates, and adheres to the `Dwifft` library implementation. 
     - The class provides easier access to sections and items of the collectionView by overriding the `UICollectionView` standard delegate functions to provide `Section` and `Item` type objects, abstracting the searching of the binded data using `IndexPath`

- [Kingfisher](https://github.com/onevcat/Kingfisher)
  - used for loading images
  
- [collection-view-layouts](https://github.com/rubygarage/collection-view-layouts)
  - for pinterest style flow layout

#### * Coding Style

My coding style tends to have more indentation and spacing, similar to writing a term paper for easier reading.

For more queries, please feel free to contact me at jay.andrae.salvador@gmail.com
