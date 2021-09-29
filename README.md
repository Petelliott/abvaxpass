# abvaxpass

abvaxpass is website that generates a signed vaccine passport from scraped
https://www.albertavaccinerecord.ca/ data. The functioning website took me 3.5
hours. Alberta health is still waiting. It is licensed under the GNU AGPL. You
probably shouldn't run this, since it violates the terms of service of Alberta
Healths website.

### how it works

1. you submit your personal health number, birthday, and vaccine month.
2. we check albertavaccinerecord.ca on your behalf to verify your vaccination status.
3. we parse your name and birthday out of the pdf, and sign it with our private key.
4. we give you a QR code with a link that contains the signed data.
5. you show it to someone and they check that the name and birthday matches your ID.
