
import pandas as pd


%sql DROP TABLE IF EXISTS listings CASCADE;
df = pd.read_csv('listings.csv', sep=',')
df.to_sql("listings", engine)

%sql DROP TABLE IF EXISTS calendar CASCADE;
df = pd.read_csv('calendar.csv', sep=',')
df.to_sql("calendar", engine)

%sql DROP TABLE IF EXISTS reviews CASCADE;
df = pd.read_csv('reviews.csv', sep=',')
df.to_sql("reviews", engine)