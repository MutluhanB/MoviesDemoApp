# MoviesDemoApp

This app is created for demonstration purposes. The app includes 2 screen MovieList and MovieDetail. Main list screen displays popular movies and detail screen displays details for selected movie. All data is provided by tmdb api.

## Code Details
Since this is not a complicated project i choose to use standard MVC architecture.
The project is consisted of 3 main parts and a few utility extensions. 

### 1- Network
Network part of the app consist of 3 main parts.

##### 1.1 - NetworkHandler
The NetworkHandler layer is responsible of making requests. There is not any third party libraries (e.g. Alamofire) in this application so networking operations implemented with native URLSessions and dataTasks.


##### 1.2 - MovieRouter
MovieRouter part of the network group is responsible of creating endpoints and corresponding urls. 


##### 1.3 - MoviesApiManager
The MoviesApiManager acts as an intermediate layer between forementioned parts and serves the correct objects to view controllers.

### 2- Storage

##### 2.1 - FavoriteManager
App requires a "favorite" mechanism so FavoriteManager provides a basic CRUD and persistence logic for favorite movies with user defaults api. 

##### 2.1 - PosterImageCacheManager
App fetches many images for each collectionview cell representing each movie. Since there is no kingfisher or alike 3rd party library for image caching and remote downloading, image fetching operations creates a huge overhead for the app. Thus i implemented a basic caching logic based on NSCache to mitigate previously mentioned problem. 

### 3- Views And ViewControllers
MovieListViewController and MovieDetailsViewController are the two view controllers for this app. Each one's code is pretty much self explanatory. View controllers uses other layers of thee app and creates the ui.

