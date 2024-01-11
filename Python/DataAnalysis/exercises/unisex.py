import pandas as pd
import matplotlib.pyplot as plot

allyears = pd.read_csv('allyears.csv.gz')
totals = allyears.groupby(['sex','name']).number.sum()
male, female = totals.loc['M'], totals.loc['F']
ratios = (totals.loc['M'] / totals.loc['F']).dropna()
unisex = ratios[(ratios > 0.5) & (ratios < 2)].index
common = (male.loc[unisex] + female.loc[unisex]).sort_values(ascending=False).head(10)
allyears_indexed = allyears.set_index(['sex','name','year']).sort_index()

plot.figure(figsize=(9,9))
for i, name in enumerate(common.index):
    plot.subplot(5,2,i+1)

    plot.plot(allyears_indexed.loc['M',name], label='M')
    plot.plot(allyears_indexed.loc['F',name], label='F')
    
    plot.legend()
    plot.title(name)
plot.tight_layout()
plot.show()
