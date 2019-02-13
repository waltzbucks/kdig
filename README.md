# kdig
Any Domains lookup test through south Korea LDNS.
This shell script for Domain lookup via Korea LDNS and other public DNS of Big providers.

# Usage
A second filed numeric values are TTL, a sixth filed numeric values are Query times.
    ~$ kdig.sh foo.com
    01) foo.com. 600   A 23.23.86.44	[KT:168.126.63.1]	231	qr-rd-ra
    02) foo.com. 600   A 23.23.86.44	[KT_LDNS:168.126.63.2]	220	qr-rd-ra
    03) foo.com. 600   A 23.23.86.44	[LGU:164.124.101.2]	206	qr-rd-ra
    04) foo.com. 600   A 23.23.86.44	[LGU:203.248.252.2]	318	qr-rd-ra
    05) foo.com. 600   A 23.23.86.44	[SKB:210.220.163.82]	288	qr-rd-ra
    06) foo.com. 438   A 23.23.86.44	[SKB:219.250.36.130]	5	qr-rd-ra
    07) foo.com. 402   A 23.23.86.44	[CJHello:180.182.54.1]	7	qr-rd-ra
    08) foo.com. 221   A 23.23.86.44	[CJHello:180.182.54.2]	8	qr-rd-ra
    09) foo.com. 401   A 23.23.86.44	[Google:8.8.8.8]	70	qr-rd-ra
    10) foo.com. 599   A 23.23.86.44	[Google:8.8.4.4]	320	qr-rd-ra
    11) foo.com. 223   A 23.23.86.44	[Cloudflare:1.1.1.1]	18	qr-rd-ra
    12) foo.com. 223   A 23.23.86.44	[Cloudflare:1.0.0.1]	5	qr-rd-ra
    13) foo.com. 395   A 23.23.86.44	[OpenDNS:208.67.222.222]	82	qr-rd-ra
    14) foo.com. 418   A 23.23.86.44	[OpenDNS:208.67.220.220]	84	qr-rd-ra
    15) foo.com. 230   A 23.23.86.44	[ComodoSecDNS:8.26.56.26]	233	qr-rd-ra
    16) foo.com. 230   A 23.23.86.44	[ComodoSecDNS:8.20.247.20]	188	qr-rd-ra
    17) foo.com. 231   A 23.23.86.44	[NortonSecA:199.85.126.10]	84	qr-rd-ra
    18) foo.com. 231   A 23.23.86.44	[NortonSecA:199.85.127.10]	537	qr-rd-ra
    19) foo.com. 231   A 23.23.86.44	[NortonSecB:199.85.126.20]	87	qr-rd-ra
    20) foo.com. 230   A 23.23.86.44	[NortonSecB:199.85.127.20]	234	qr-rd-ra
    21) foo.com. 230   A 23.23.86.44	[NortonSecC:199.85.126.30]	97	qr-rd-ra
    22) foo.com. 230   A 23.23.86.44	[NortonSecC:199.85.127.30]	380	qr-rd-ra
      * NortonSecA is Security (malware, phishing sites and scam sites)
      * NortonSecB is Security + Pornography
      * NortonSecC is Security + Pornography + Non-Family Friendly
    
    -- uniq result (1) ----------------------------------------------
    
      23.23.86.44

