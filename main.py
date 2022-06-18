def fn(l):
    l.sort()
    s = l[0]
    for i in range(1,len(l)):
        if l[i] != l[i-1]+1:
            print(f"{s}   {l[i-1]}")
            s = l[i]
    print(f"{s}   {l[-1]}")
fn([22,25,500,501,502,503,3])