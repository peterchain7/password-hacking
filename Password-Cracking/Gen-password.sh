#!bin/bash

   # /etc/john/john.conf
   # CapitalizeChar all fist chars from wordlist -- and add special character to it,
   # c - Capitalize, l - small letter, u - UPPERCASE
   # [List.Rules:CapitalizeChar]
   # c
   # l$[0-9]
   # l$[0-9]$[0-9]
   # l$[!@#$%^&*()+=.?] 
   # l$[!@#$%^&*()+=.?]$[!@#$%^&*()+=.?]
   # l$[0-9]$[!@#$%^&*()+=.?]
   # l$[0-9]$[0-9]$[!@#$%^&*()+=.?]$[!@#$%^&*()+=.?]
   # Usage: ─$ bash Gen-password.sh| sudo aircrack-ng handshake-01.cap -b 1C:BF:CE:A2:3B:51 -w -
   # -Note - in -w -,single dash - Unix convention(read from standard input (stdin))
    
 # NUMBER(e.g., 2025)
   john  --stdout --mask='?d?d?d?d?d?d?d?d?d'
   john  --stdout --mask='?d?d?d?d?d?d?d?d'
   john  --stdout --mask='?d?d?d?d?d?d?d'
   john  --stdout --mask='?d?d?d?d?d?d'
   john  --stdout --mask='?d?d?d?d?d'
   john  --stdout --mask='?d?d?d?d'
   john  --stdout --mask='?d?d?d'
   john  --stdout --mask='?d?d'
   john  --stdout --mask='?d'

for list in animals.txt football-players.txt football.txt others.txt rivers.txt taasisi.txt tz-region-district.txt tz-usernames.txt uhamiaji.txt; do
 	# Single Special Character Script
 	# Targets: tz-usernames.txt tz-region-district.txt football.txt others.txt rivers.txt animals.txt taasisi.txt

    # WORD (e.g., Simba)
    john --wordlist=$list --stdout --mask='?w'


    # WORD + NUMBER (e.g., Simba2025)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d?d'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d'
   
    # NUMBER + WORD (e.g., 2025Simba)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d?d?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?w'

#     #NUMBER + WORD + 1CHAR (eg, 2025Juma@)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d?d?w[!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d?w[!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?w[!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?w[!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?w[!@#$%^&*+,-.?/;":=]'
    
#     # NUMBER+ 1CHAR + WORD (e.g., 2025@Simba)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d[!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d[!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d[!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d[!@#$%^&*+,-.?/;":=]?w'

#     # WORD + 2 CHAR (e.g., Simba!)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=]' 


#     # 1 CHAR +WORD  (e.g., !Simba)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=]?w' 


    # WORD + 1 CHAR + NUMBER (e.g., Simba!2025)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=]?d?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=]?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=]?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=]?d' 

    # WORD + NUMBER + 1 CHAR (e.g., Simba2025!)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d?d[!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d[!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d[!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d[!@#$%^&*+,-.?/;":=]' 

    # 1 CHAR + WORD + NUMBER (e.g., !Simba2025)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=]?w?d?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=]?w?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=]?w?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=]?w?d'

	# Double Special Character Script
	# Targets: tz-usernames.txt tz-region-district.txt football.txt others.txt rivers.txt animals.txt taasisi.txt
	
	# WORD + 2 CHAR (e.g., Simba!@)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' 
    
    # 2CHAR + WORD (e.g., @#Simba)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' 

    
    # WORD + 2 CHARS + NUMBER (e.g., Simba!!2025)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d' 

    # WORD + NUMBER + 2 CHARS (e.g., Simba2025!!)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?w?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' 

    # 2 CHARS + WORD + NUMBER (e.g., !!Simba2025)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d' 
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d' 

   # NUMBER + 2 CHARS + WORD +  (e.g., 2025@!Simba)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w'
  
   # NUMBER  + WORD + 2 CHARS (e.g., 2025Simba@!)
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]'
    john --wordlist=$list --stdout --rules=CapitalizeChar --mask='?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]'
done