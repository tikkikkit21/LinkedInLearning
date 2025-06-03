import numpy as np
import matplotlib.pyplot as pp
import getweather

def smooth(array, window=10, mode='valid'):
    return np.correlate(array, np.ones(window)/window, mode)

station = 'NEW YORK'
allyears = np.arange(1880, 2020)
alldata = np.vstack([getweather.getyear(station, ['TMIN','TMAX'], year)
                     for year in allyears])
allavg = np.nanmean(0.5 * (alldata['TMIN'] + alldata['TMAX']), axis=1)
midcentury = np.nanmean(allavg[65:75])

pp.plot(allyears, allavg - midcentury)
pp.plot(allyears[4:-4], smooth(allavg - midcentury, 9, 'valid'))
pp.show()
