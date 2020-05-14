# create_file.R

# From https://theautomatic.net/2020/05/12/how-to-schedule-r-scripts/?utm_source=rss&utm_medium=rss&utm_campaign=how-to-schedule-r-scripts&subscribe=many_pending_subs#blog_subscription-3

nums <- sample(1000,100)
write(nums,"sample_numbs.txt")