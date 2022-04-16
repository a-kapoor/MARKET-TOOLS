security="$1"
from="$2"
to="$3"
interval="$4"
ofile="$5"
#python zdata.py -i "NSE:NIFTY 50" -f 2020-11-01 -t 2020-12-02 -n minute -o data.csv
python zdata.py -i "$security" -f "$from" -t "$to" -n "$interval" -o "$ofile"
