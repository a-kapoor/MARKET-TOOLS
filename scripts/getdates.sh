startdate="2012-01-01"
s=$startdate
for d in {0..6}
do
    e=$(date -d "$s + 50 days" +'%Y-%m-%d')
    echo ${s} - ${e}
    s=$(date -d "$e + 1 day" +'%Y-%m-%d')
    
done
