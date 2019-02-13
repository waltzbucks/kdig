#!/bin/bash
# write by donhyun.lee 2005.12.20
# update by donhyun.lee 2009.11.11

CDRED='\e[1;49;91m'
CRED='\e[7;49;91m'
CGREEN='\e[1;49;92m'
CDGREEN='\e[7;49;92m'
CYELLOW='\e[1;49;93m'
CDYELLOW='\e[7;49;93m'
CBOLD=""
CBLUE=""
CGREY=""
CEND='\e[0m'


DigOutput=~/.dig_output.txt
DigResult=~/.dig_result.txt
> $DigOutput
> $DigResult

if [ $# -ne 1 ]; then
         HOST="foo.com"
else 
        HOST=$1
fi
#clear

###############################################################
# KT
  # 168.126.63.1
  # 168.126.63.2
# LGU+
  # 164.124.101.2
  # 203.248.252.2
# SKB
  # 210.220.163.82
  # 219.250.36.130
# CJHello
  # 180.182.54.1
  # 180.182.54.2
# Google
  # 8.8.8.8
  # 8.8.4.4
# Cloudflare
  # 1.1.1.1
  # 1.0.0.1
#OpenDNS
  # 208.67.222.222
  # 208.67.220.220
#Comodo Secure DNS
  # 8.26.56.26
  # 8.20.247.20
#Norton ConnectSafe[5]
  # 199.85.126.10 #Security (malware, phishing sites and scam sites)
  # 199.85.127.10	
  # 199.85.126.20 #Security + Pornography
  # 199.85.127.20 
  # 199.85.126.30 #Security + Pornography + Non-Family Friendly
  # 199.85.127.30
	
###############################################################

CNT=1
for dnslist in  168.126.63.1:KT 168.126.63.2:KT_LDNS \
164.124.101.2:LGU 203.248.252.2:LGU \
210.220.163.82:SKB 219.250.36.130:SKB \
180.182.54.1:CJHello 180.182.54.2:CJHello \
8.8.8.8:Google 8.8.4.4:Google \
1.1.1.1:Cloudflare 1.0.0.1:Cloudflare \
208.67.222.222:OpenDNS 208.67.220.220:OpenDNS \
8.26.56.26:ComodoSecDNS 8.20.247.20:ComodoSecDNS \
199.85.126.10:NortonSecA 199.85.127.10:NortonSecA \
199.85.126.20:NortonSecB 199.85.127.20:NortonSecB \
199.85.126.30:NortonSecC 199.85.127.30:NortonSecC

        do
        ISP=""


        #dig @$dns $HOST | egrep "($HOST)"
        if [ $CNT -le 9 ]; then
                CNT2=0$CNT
        else
                CNT2=$CNT
        fi

        dns=`echo "${dnslist}" | awk -F":" '{print $1}'`
        ISP=`echo "${dnslist}" | awk -F":" '{print $2}'`

        #echo "dig @$dns $HOST +time=1 +tries=2|grep -A 1 "ANSWER SECTION"|grep -v "ANSWER SECTION"|awk -F" " '{print $1,$2,$5}'"
        #Result3=`dig @$dns $HOST +time=1 +tries=2|grep -A 4 "ANSWER SECTION"|grep -v "ANSWER SECTION"|awk -F" " '{print $1,$2,$5}' | awk -F" " '{print $3}' | fmt -w 1000 | sed -e 's/  / /g' -e 's/ /:/g'`
        #Result=`dig @$dns $HOST +time=1 +tries=2|grep -A 1 "ANSWER SECTION"|grep -v "ANSWER SECTION"|awk -F" " '{print $1,$2,$5,$4}' | tee -a $DigResult`
        
        #R1=`echo $Result|awk -F" " '{print $1}'`
        #R2=`echo $Result|awk -F" " '{print $2}'`
        #R3=`echo $Result|awk -F" " '{print $3}'`
        #R4=`echo $Result|awk -F" " '{print $4}'`
        
	Result=(`dig $HOST @$dns +time=1 +tries=3 | awk -v host="$HOST" -v dns="$dns" '{
			if($0~"flags: ") {
				split($0,flags,";");
				split(flags[3],flag,": ");
				gsub(" ","-",flag[2])
			};
			if($0~"Query time") {
				split($0,que," ")
			};
			if($1==host".") split($0,lookup," ");
			if(lookup[1]=="") {
				lookup[1]=host".";
				lookup[2]="Failed"
			}
		}
		END{print lookup[1],lookup[2],lookup[5],lookup[4],que[4],flag[2]}'`)

        R1=${Result[0]}
        R2=${Result[1]}
        R3=${Result[2]}
        R4=${Result[3]}
        R5=${Result[4]}
        FLAG=${Result[5]}        

        R1_WC=`echo $R1 | wc -c`
        RES_COL=$[R1_WC + 11]
        MOVE_TO_COL="echo -en \\033[${RES_COL}G"

        #if [ -n "$Result" ]; then
        if [ "$R2" != "Failed" ]; then
                echo -e "$CNT2) $R1 $R2 $R3 $ISP:$dns $R5 $FLAG" >> $DigOutput 2>/dev/null
                
                if [ "CNAME" == "$R4" ]; then
                        echo -en "${CDYELLOW}$CNT2) $R1${CEND} ${CYELLOW}$R2"
                        $MOVE_TO_COL
                        echo -e "$R4 $R3\t[$ISP:$dns]\t$R5\t$FLAG${CEND}"
                else
                        echo -en "${CDGREEN}$CNT2) $R1${CEND} ${CGREEN}$R2"
                        $MOVE_TO_COL
                        echo -e "$R4 $R3\t[$ISP:$dns]\t$R5\t$FLAG${CEND}"
                fi
        else
                echo -en "${CRED}$CNT2) $R1${CEND} ${CDRED}FAILED"
                $MOVE_TO_COL
                echo -e "N/A N/A\t[$ISP:$dns]\t$R5\t$FLAG${CEND}"
        fi
        if [ "$CNT" == "22" ]; then
                echo -e "  * NortonSecA is Security (malware, phishing sites and scam sites)\n  * NortonSecB is Security + Pornography\n  * NortonSecC is Security + Pornography + Non-Family Friendly"
        fi
        
        CNT=$[$CNT + 1 ]
        
done
echo

IPCnt=`awk -F" " '{print $4}' $DigOutput  | sort | uniq | wc -l`
echo "-- uniq result (${IPCnt}) ----------------------------------------------"
echo
echo -e "  `awk -F" " '{print $4}' $DigOutput  | sort | uniq | fmt -w 1000`"
