percentage <- c(85, 93, 89, 84, 58, 82, 57, 67, 97, 97, 89, 78)
votes_trump <- c(7156, 8321, 14010, 153472, 32850, 39278, 29561, 231845, 323863, 254561, 31183, 97439)
votes_biden <- c(5077,6107, 12406, 141078, 20206, 26016, 17843, 489165, 431656, 216512, 14282, 102322)
counties <- c("Charlevoix","Manistee","Isabella","Kent"
              ,"Allegan", "Jackson","Monroe","Wayne", "Oakland",
              "Macomb", "Lapeer", "Genesee")
expected_biden <- votes_biden / percentage * 100
expected_trump <- votes_trump / percentage * 100
sumTrump <- cumsum(expected_trump)
sumBiden <- cumsum(expected_biden)

data <- data.frame(
  counties,
  votes_trump,
  votes_biden,
  expected_trump,
  expected_biden,
  sumTrump,
  sumBiden,
  percentage)

TotalvotesTrump <- data[12, 6]
TotalvotesBiden <- data[12, 7]
Difference <- TotalvotesTrump - TotalvotesBiden
data <- data.frame(
  counties,
  votes_trump,
  votes_biden,
  expected_trump,
  expected_biden,
  sumTrump,
  sumBiden,
  percentage,
  TotalvotesBiden,
  TotalvotesTrump,
  Difference)
df1 <- data.frame(counties, expected_biden, votes_biden, expected_trump, votes_trump)
df2 <- melt(df1, id.vars ='counties')

ggplot(df2, aes(x=counties, y=value, fill=variable)) + geom_bar(stat = 'identity', position = 'dodge') + scale_fill_manual("Legend", values = c("expected_trump" = "red", "expected_biden" = "blue", "votes_biden" = "cyan", "votes_trump" = "pink"))