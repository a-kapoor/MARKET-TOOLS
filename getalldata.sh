outputdir="Shash"
prefix="Trial"

mkdir $outputdir

### All the durations you want for the stock (in max 60 day interval, I suggest 1 month at a time)
. getOneTimedata.sh "NSE:NIFTY 50" 2020-11-01 2020-12-02 minute $outputdir/${prefix}_1.csv
. getOneTimedata.sh "NSE:NIFTY 50" 2019-11-01 2019-12-02 minute $outputdir/${prefix}_2.csv
. getOneTimedata.sh "NSE:NIFTY 50" 2018-11-01 2018-12-02 minute $outputdir/${prefix}_3.csv
. getOneTimedata.sh "NSE:NIFTY 50" 2017-11-01 2017-12-02 minute $outputdir/${prefix}_4.csv

### Combine all csvs into one
awk 'FNR==1 && NR!=1{next;}{print}' $outputdir/${prefix}*.csv > $outputdir/bigfile.csv

### Preprocess to high-low
python preprocess.py --file-name $outputdir/bigfile.csv --output $outputdir/bigfile_converted.csv
