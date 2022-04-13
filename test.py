s = 'un2n082 ot9zju7sm2'
flag = []
for c in s:
     c = chr(ord(c) ^ ord('-'))
     c = chr(ord(c) ^ ord('.'))
     flag.append(c)
flag[7] = 'A'
print(''.join(flag))