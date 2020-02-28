#----------------------------------------------------------------------------
# set_up_rcbd.R
#
# The package agricole provides randomization and set-up. It can probably
# be done more simply and efficiently from base SAS and/or dplyr
#
#----------------------------------------------------------------------------

library(tidyr)

## Indicate dimensions of RCBD
nmbr_reps <- 7
nmbr_trt <- 12

## Get treatment codes
trtcodes <- LETTERS[1:nmbr_trt]

## Get vector of replicate numbers
Rep <- rep(seq(1:nmbr_reps), each = nmbr_trt)

## Get vector of position within replicate
Postn <- rep(seq(1:nmbr_trt),nmbr_reps)

## Get vector of randomized treatments
#TrtCode <- rep(sample(trtcodes),nmbr_reps)
#--The above didn'nt work. Instead making a for-loop to randomize trtcodes
#--nmbr_reps times and, with each iteration, append to a vector
TrtCode <- 

## Output randomization in list (long) form
rcbd_table <- data.frame(Rep,Postn,TrtCode)

head(rcbd_table,nmbr_trt+1)

## Output randimization in grid
rcbd_grid <- rcbd_table %>% 
  pivot_wider(names_from = Rep, values_from = TrtCode, names_prefix = "Rep")

rcbd_grid
