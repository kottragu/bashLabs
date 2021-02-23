net stop dns

timeout /t 20
sc query type= service > C:\osi\task3\new_services.txt

fc C:\osi\task3\new_services.txt C:\osi\task3\services.txt > different.txt

net start dns