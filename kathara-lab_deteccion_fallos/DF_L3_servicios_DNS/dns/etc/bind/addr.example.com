$ORIGIN 11.4.10.in-addr.arpa.
$TTL 86400
@     IN     SOA    ns1.example.com.   hostmaster.example.com. (
	2023010101 ; serial
	21600      ; refresh after 6 hours
	3600       ; retry after 1 hour
	604800     ; expire after 1 week
	86400 )    ; minimum TTL of 1 day
        
     IN     NS     ns1.example.com.
;     IN     NS     ns2.example.com.
5    IN     PTR    host5.example.com.
6    IN     PTR    host6.example.com.
7    IN     PTR    host7.example.com.
8    IN     PTR    host8.example.com.

