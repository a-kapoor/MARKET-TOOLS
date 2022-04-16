#outputdir="Data"
#startdate="2015-01-01"
#months=3
#stock="NSE:NIFTY 50"

######################################################################
###### DO NOT MODIFY Below this#########
echo !!##!!----------------------!!##!!----------------------
echo Starting a new query!!
echo !!##!!----------------------!!##!!----------------------

prefix="file"
rm -rf output/$outputdir
mkdir output/$outputdir

s=$startdate
echo Generating 30 days at a time!
for d in $(seq $months)
do
    e=$(gdate -d "$s + 30 days" +'%Y-%m-%d')
    echo Generating for: ${s} - ${e}
    . scripts/getOneTimedata.sh "$stock" "$s" "$e" minute output/$outputdir/${prefix}_$d.csv
    s=$(gdate -d "$e + 1 day" +'%Y-%m-%d')
done
echo Combining and preprocessing!
### Combine all csvs into one
awk 'FNR==1 && NR!=1{next;}{print}' output/$outputdir/${prefix}*.csv > output/$outputdir/bigfile.csv

### Preprocess to high-low
python scripts/preprocess.py --file-name output/$outputdir/bigfile.csv --output output/$outputdir/bigfile_converted.csv

echo Find output here: output/$outputdir/bigfile_converted.csv

#######################################################
