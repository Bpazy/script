curl 'https://www.clashcloud.net/auth/login' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' --data 'LOGIN_DATA' --compressed -c ssrcloud_cookie.txt
curl 'https://www.clashcloud.net/user/checkin' -X POST -b ssrcloud_cookie.txt
