import sys

vcf_file = sys.argv[1]

count = 0

with open(vcf_file) as f:
    for line in f:
        if not line.startswith("#"):
            count += 1

print("Total variants detected:", count)
