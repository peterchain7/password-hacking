#!/bin/bash
# High-Performance John the Ripper Wrapper
# Optimized for 28-Thread / 8-Core Environments

# --- ARGUMENT HANDLING ---
usage() {
    echo "Usage: $0 -f <path_to_hashes> [additional_john_arguments]"
    echo "Example: $0 -f domain.ntds --format=NT --fork=8 --rules=CapitalizeChar"
    exit 1
}

HASHES=""

# 1. Parse only the -f flag for script logic
while getopts ":f:h" opt; do
  case $opt in
    f) HASHES="$OPTARG" ;;
    h) usage ;;
    \?) break ;; # Stop at first unknown (like --format)
  esac
done

# 2. Shift to capture all remaining arguments (e.g., --format, --fork, --rules)
shift $((OPTIND - 1))
USER_ARGS="$@"

# 3. Validation
if [[ -z "$HASHES" || ! -f "$HASHES" ]]; then
    echo "[-] Error: Provide valid path to hashes with -f"
    usage
fi

echo "[+] Target Hashes: $HASHES"
echo "[+] John Arguments: $USER_ARGS"

# --- SECTION 1: GLOBAL NUMERIC ATTACKS ---
# We strip --rules only here, because John crashes if --rules 
# is used without a wordlist. All other args (format, fork, etc) remain.
NUMERIC_ARGS=$(echo "$USER_ARGS" | sed 's/--rules=[^ ]*//g')

echo "[+] Starting Global Numeric Audit..."
for d in 9 8 7 6 5 4 3 2 1; do
    mask=""
    for ((i=1; i<=$d; i++)); do mask="${mask}?d"; done
    john $NUMERIC_ARGS --mask="$mask" "$HASHES"
done

# --- SECTION 2: THE WORDLIST LOOP ---
# Pattern: [John] [Wordlist] [User Args] [Mask Logic] [Target]
for list in tz-usernames.txt tz-region-district.txt football.txt others.txt rivers.txt animals.txt taasisi.txt; do
    if [[ ! -f "$list" ]]; then 
        echo "[!] Skipping missing wordlist: $list"
        continue 
    fi

    echo "[+] Current Wordlist: $list"

    # WORD (e.g., Simba)
    john --wordlist=$list $USER_ARGS --mask='?w' "$HASHES"

    # WORD + NUMBER (e.g., Simba2025)
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d' "$HASHES"
   
    # NUMBER + WORD (e.g., 2025Simba)
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d?d?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?w' "$HASHES"

    # NUMBER + WORD + 1CHAR (eg, 2025Juma@)
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d?d?w[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d?w[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?w[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?w[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?w[!@#$%^&*+,-.?/;":=]' "$HASHES"
    
    # NUMBER+ 1CHAR + WORD (e.g., 2025@Simba)
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d[!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d[!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d[!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d[!@#$%^&*+,-.?/;":=]?w' "$HASHES"

    # WORD + 1 CHAR (e.g., Simba!)
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=]' "$HASHES"

    # 1 CHAR +WORD  (e.g., !Simba)
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=]?w' "$HASHES"

    # WORD + 1 CHAR + NUMBER (e.g., Simba!2025)
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=]?d?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=]?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=]?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=]?d' "$HASHES"

    # WORD + NUMBER + 1 CHAR (e.g., Simba2025!)
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d?d[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d[!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d[!@#$%^&*+,-.?/;":=]' "$HASHES"

    # 1 CHAR + WORD + NUMBER (e.g., !Simba2025)
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=]?w?d?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=]?w?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=]?w?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=]?w?d'

    ## Double Special Character Script
    
    # WORD + 2 CHAR (e.g., Simba!@)
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    
    # 2CHAR + WORD (e.g., @#Simba)
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' "$HASHES"

    # WORD + 2 CHARS + NUMBER (e.g., Simba!!2025)
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?d' "$HASHES"

    # WORD + NUMBER + 2 CHARS (e.g., Simba2025!!)
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?w?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"

    # 2 CHARS + WORD + NUMBER (e.g., !!Simba2025)
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d?d' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w?d' "$HASHES"

    # NUMBER + 2 CHARS + WORD +  (e.g., 2025@!Simba)
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]?w' "$HASHES"
  
    # NUMBER  + WORD + 2 CHARS (e.g., 2025Simba@!)
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
    john --wordlist=$list $USER_ARGS --mask='?d?w[!@#$%^&*+,-.?/;":=][!@#$%^&*+,-.?/;":=]' "$HASHES"
done