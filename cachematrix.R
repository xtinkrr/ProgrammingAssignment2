## The two functions below creates a matrix capable of caching its
## inverse. Performing matrix inversion only if the inverse hasn't
## been computed before. And accessing the cached inverse, otherwise.

## This first function creates the desired "matrix" object in the form
## of a list of functions providing the caching mechanisms.

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) i <<- inverse
    getinverse <- function() i
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## This second function wraps the matrix inverse ("solve") function.
## It utilizes the caching mechanisms provided by the "matrix" object
## returned from the first function. Checking the cache first before
## actually calling the "solve" function.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    i <- x$getinverse()
    if(!is.null(i)) {
        return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinverse(i)
    i
}