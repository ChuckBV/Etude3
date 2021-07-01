# plot_scratch.R

### 4 x 4 grid, east-west (north-south rows)

x <- c(0.125,0.25,0.25,0.25)
y <- cumsum(x)
y
# [1] 0.125 0.375 0.625 0.875

rows <- x*148
rows <- c(19,37,37,37)
rows <- cumsum(rows)
rows
# [1]  19  56  93 130

trees <- x*160
trees <- cumsum(trees)
trees
# [1]  20  60 100 140

rowft <- x*2817
rowft <- cumsum(rowft)
rowft <- rowft%/%1
rowft
# [1]  352 1056 1760 2464

### 3 x 3 grid,  east-west (north-south rows)

x <- c(0.5*1/3,1/3,1/3)
y <- cumsum(x)
y
# [1] 0.1666667 0.5000000 0.8333333

rows <- x*148
rows <- rows%/%1
# [1] 24 49 49
rows <- cumsum(rows)
rows
# [1]  24  73 122

trees <- x*160
trees <- cumsum(trees)
trees <- trees%/%1
trees
# [1]  26  80 133

rowft <- x*2817
rowft <- cumsum(rowft)
rowft <- rowft%/%1
rowft
# [1]  469 1408 2347

treeft <- x*2557

### 4 x 4 grid, north-south (north-south rows)

x <- c(0.125,0.25,0.25,0.25)
y <- cumsum(x)
y
# [1] 0.125 0.375 0.625 0.875

# Row length measured at 2557. Tree space estimated ast 16. Tree per row:
trees_pr_row <- (2557/16)%/%1
trees_pr_row
# [1] 159
trees_pr_row <- 160 # round estimate

trees <- x*160
trees <- cumsum(trees)
trees