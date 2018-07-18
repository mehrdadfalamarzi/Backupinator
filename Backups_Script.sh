#!/bin/sh

#####START##################
#####Variable###############

date=$(date +%Y-%m-%d)
backup_name_1=backupname1-$date.tar.gz
backup_name_2=backupname2-$date.tar.gz
backup_name_3=backupname3-$date.tar.gz

source_backup_name_1=/insert_path_1_here/*
source_backup_name_2=/insert_path_2_here/*
source_backup_name_3=/insert_path_3_here/*

destination=/insert_path_destination_here/...

#####Variable###############
#####Start Backups##########

tar -cpzf $destination/$backup_name_1 $source_backup_name_1 &
tar -cpzf $destination/$backup_name_2 $source_backup_name_2 &
tar -cpzf $destination/$backup_name_3 $source_backup_name_3 &

wait

ls /insert_path_destination_here/... > ListTemp

for i in `cat ListTemp`
do
creatdate=`echo $i | sed "s/-/ /g"  | awk '{ print $2,$3,$4 }' | sed "s/ /-/g" | sed "s/.tar.gz/ /g"`
Difference=`echo $(($(($(date -d "$date" "+%s") - $(date -d "$creatdate" "+%s"))) / 86400))`
if(( $Difference >= 28 ))
then
rm -rf /insert_path_destination_here/$i
fi
done
rm -rf ListTemp

#####End Backups#############
#####Mail Backup Report######

cd /insert_path_destination_here/
ListSort=`du -hsx * | sort -rh`
Total=`du -ch /insert_path_destination_here/`
function MailBackupReport {
    echo "Dear teammate"
    echo
    echo "Backup operation completed successfully"
    echo
    echo "Backup list"
    echo
    echo "$ListSort"
    echo
    echo "$Total"
    echo
    echo "Sincerely | Devops manager"
}
MailBackupReport | /usr/bin/mail -s "Topic" yourـemailـAddress



#####Mail Backup Report######
#####End#####################


