#!/bin/bash
# calculate P & S travel time
rm *.tp

step 1

file=phase.dat
    cat $file | awk '{print NR" "$0}' | grep 2017 | sed 's/,/ /g' > row_num_all.txt
    awk '{print $1,$9,$10,$16}' row_num_all.txt > row_num.txt
    sed '1d' row_num.txt > 1.cat
    sed '$i 1000000' 1.cat > 2.cat
    paste row_num.txt 2.cat > new_row_num.txt
    rm row_num.txt row_num_all.txt *cat

      for event in $(cat new_row_num.txt | awk '{print NR}')
          do
             num1=`cat new_row_num.txt | awk 'NR=="'"$event"'"{print $1+1}'`
             lat=`cat new_row_num.txt | awk 'NR=="'"$event"'"{print $2}'`
             lon=`cat new_row_num.txt | awk 'NR=="'"$event"'"{print $3}'`
             num2=`cat new_row_num.txt | awk 'NR=="'"$event"'"{print $5-1}'`
             evID=`cat new_row_num.txt | awk 'NR=="'"$event"'"{print $4}'`
             sed -n "${num1},${num2}p" $file > $evID.tp
             sed -i "s/PJ0/$lat $lon &/" $evID.tp
             sed -i "s/PJ01/ 33.227 103.901 &/" $evID.tp
             sed -i "s/PJ02/ 33.161 103.895 &/" $evID.tp
             sed -i "s/PJ03/ 33.099 103.919 &/" $evID.tp
             sed -i "s/PJ04/ 33.048 103.933 &/" $evID.tp
             sed -i "s/PJ05/ 33.109 103.708 &/" $evID.tp
             sed -i "s/PJ06/ 33.146 103.726 &/" $evID.tp
             sed -i "s/PJ07/ 33.237 103.741 &/" $evID.tp
             sed -i "s/PJ08/ 33.266 103.773 &/" $evID.tp
             sed -i "s/PJ09/ 33.326 103.752 &/" $evID.tp
           done
        cat *.tp > sum.txt
        rm *.tp
step 2.
        for et in $(cat sum.txt | awk '{print NR}')
          do
              eqlat=`cat sum.txt  | awk 'NR=="'"$et"'"{print $1}'`
              eqlon=`cat sum.txt  | awk 'NR=="'"$et"'"{print $2}'`
              stlat=`cat sum.txt  | awk 'NR=="'"$et"'"{print $3}'`
              stlon=`cat sum.txt  | awk 'NR=="'"$et"'"{print $4}'`
              ./distaz $stlat $stlon $eqlat $eqlon >> distazsum.tp
           done
        paste sum.txt distazsum.tp > finaldis.txt
