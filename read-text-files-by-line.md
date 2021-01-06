# Reading text files by line in Reading

## SCRIPT USING fileName()

https://stackoverflow.com/questions/12626637/read-a-text-file-in-r-line-by-line

```
fileName="up_down.txt"
con=file(fileName,open="r")
line=readLines(con) 
long=length(line)
for (i in 1:long){
    linn=readLines(con,1)
    print(linn)
}
close(con)
```

## 6 EXAMPLE CODES: readLines(), n.readLines() & readline() in R

https://statisticsglobe.com/r-readlines-example

## Read File in R Line by Line

```
# Similar to the previous script
path <- "/path/to/the/file"
print(path)
 
conn <- file(path,open="r")
lines <- readLines(conn)
for (i in 1:length(lines)){
   print(lines[i])
}
close(conn)
```

## READING FILE CONTENT WITH scan()

https://statisticsglobe.com/r-scan-function-example