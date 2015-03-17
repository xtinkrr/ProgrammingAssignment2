## This is a test provided to show compare the execution speed difference
## in using the default solve function and using the functions in 
## "cachematrix.R".

## The 10x10 matrix to be inverted.
set.seed(1)
x = matrix(rnorm(100), 10, 10)

## Setup calling the solve function 1000 times in a loop.
no_cache <- function(x) {
    for(i in 1:1000){
        solve(x)
    }
    invisible(solve(x))
}

## Setup calling the cacheSolve function 1000 times in a loop.
with_cache <- function(y) {
    y <- makeCacheMatrix(x)
    for(i in 1:1000){
        cacheSolve(y)
    }
    invisible(cacheSolve(y))
}

## Estimate average execution time with and without cache. A modified snippet
## from one of the answers here: 
## http://stats.stackexchange.com/questions/3235/timing-functions-in-r.

## Repeat the setup 100 times.
N <- 100

nc_ave = mean(replicate(N, system.time(no_cache(x) )[3]), trimmed=0.05)
wc_ave = mean(replicate(N, system.time(with_cache(x) )[3]), trimmed=0.05) 

cat("Estimated execution time of 1000 solve() calls in a loop:", nc_ave, "s", fill=TRUE)
cat("Estimated execution time of 1000 cacheSolve() calls in a loop:", wc_ave, "s", fill=TRUE)