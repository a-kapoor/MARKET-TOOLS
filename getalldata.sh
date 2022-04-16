outputdir="Data"
startdate="2019-01-01"
months=7
stock="NSE:NIFTY 50"

######################################################################
###### DO NOT MODIFY Below this#########
prefix="file"
rm -rf output/$outputdir
mkdir output/$outputdir

s=$startdate
echo Generating 30 days at a time!
for d in $(seq $months)
do
    e=$(date -d "$s + 30 days" +'%Y-%m-%d')
    echo Generating for: ${s} - ${e}
    . scripts/getOneTimedata.sh "$stock" "$s" "$e" minute output/$outputdir/${prefix}_$d.csv
    s=$(date -d "$e + 1 day" +'%Y-%m-%d')
done
echo Combining and preprocessing!
### Combine all csvs into one
awk 'FNR==1 && NR!=1{next;}{print}' output/$outputdir/${prefix}*.csv > output/$outputdir/bigfile.csv

### Preprocess to high-low
python scripts/preprocess.py --file-name output/$outputdir/bigfile.csv --output output/$outputdir/bigfile_converted.csv

echo Find output here: output/$outputdir/bigfile_converted.csv

#######################################################
