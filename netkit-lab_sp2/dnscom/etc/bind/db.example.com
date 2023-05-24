$TTL    60000
@               IN      SOA     dns.example.com.    root.dns.example.com. (
                        20200509 ; serial
                        28 ; refresh
                        14 ; retry
                        3600000 ; expire
                        0 ; negative cache ttl
                        )
@               IN      NS      ramirez.example.com.
@               IN      NS      murena.example.com.
murena		IN	A	80.65.32.192
ramirez		IN	A	40.130.16.34
respaldo	IN	A	56.3.243.65
www		IN	A	120.30.60.5
datos		IN	A	80.64.34.2
