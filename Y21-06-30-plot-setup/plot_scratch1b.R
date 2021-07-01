# plot_scratch1b.R

# Deterime trap positions for mark-release-recapture on the 
# Mike Woolf I-5 Huron site.

# Needed:
# 1) A grid of 1 trap station per 10 acres. Each station will have
#    one pheromone and one bait trap.
# 2) A grid of pheromone-PPO traps placed mid-way between the 
#    phero/bait trap stations.

# Mike Woolf I-5east site (36.123192,-120.131295)
# - Spacing: 19 ft rows, 16 ft tree space within rows
# - Northeast 160 acre block: 2600 x 2600 ft (0.5 mile = 2640)
# - Southeast partial 160: also 2600 ft north-south
# - North edge: 4700 feet
# - Middle east-west road: 2800 feet
# - South edge: 840 ft

### Phero-bait grid

# Start with northeast side, determine how to evenly place 
# a 4 x 4 grid of 16 traps there

# Proportion of distance for 4 x 4 grid
grid_props <- c(0.125,0.25,0.25,0.25)
grid_props <- cumsum(grid_props)
grid_props
# [1] 0.125 0.375 0.625 0.875


# Feet from northeast corner for a 4 x 4 grid
grid_ft <- grid_props*2600
grid_ft
# [1]  325  975 1625 2275
  # so 650 ft apart
north_ft <- seq(from = 325, to = 3575, by = 650)
north_ft
# [1]  325  975 1625 2275 2925 3575

# Rows from northeast side
grid_row <- (north_ft/19)%/%1
grid_row
# [1]  17  51  85 119  153 188
  # So 34 rows apart

# Trees from north edge
east_ft <- seq(from = 325, to = 5240, by = 650)
east_ft
# [1]  325  975 1625 2275 2925 3575 4225 4875

grid_trees <- (east_ft/16)%/%1
grid_trees
# [1]  20  60 101 142 182 223 264 304

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