def draw_maze(s):
    maze = s.splitlines()
    h = len(maze)
    w = len(maze[0])
    g = Graphics()
    g += line([(0,0), (w,0), (w,h), (0,h), (0,0)])
    for y in xrange(0, h):
        for x in xrange(0, w):
            if maze[y][x] == '#':
                g += polygon([(x,h-y-1), (x+1,h-y-1), (x+1, h-y), (x,h-y)])
            elif maze[y][x] == '1':
                g += polygon([(x,h-y-1), (x+1,h-y-1), (x+1, h-y), (x,h-y)], rgbcolor=(1,0.9,1))
    g.axes(False)
    return g

def animated_search(s, enter, exit):
    return  

def succ(v, N):
    l = []
    if v[0] != 0:
        l.append((v[0] - 1, v[1]))
    if v[1] != 0:
        l.append((v[0], v[1] - 1))
    if v[0] != N-1:
        l.append((v[0] + 1, v[1]))
    if v[1] != N-1:
        l.append((v[0], v[1] + 1))
    return l

def solve_maze(s):
    l = s.splitlines()
    N = len(l)
    ll = []
    animation = []
    for st in l:
        ll.append(list(l))
    plan = [(0,0)]
    while(len(plan) > 0):
        v = plan.pop()
        ll[v[0]][v[1]] = '1'
        animation.append(draw_maze(ll))
        for x in succ(v, N):
            if l[x[0]][x[1]] == '#':
                continue
            if x == (N - 1, N - 1):
                print "YES"
                return animate(animation)
            if ll[x[0]][x[1]] != '1':
                plan.append(x)
    print "NO"
    return animate(animation)


s = """...#.#.#.#.....
.###.#.#.#.#.##
...#.#...#.#.#.
##.#.#.###.###.
.........#.#.#.
.###.#####.#.#.
.#.............
####.#.#.###.##
.....#.#...#...
####.#.#.#.###.
.....#.#.#...#.
.#.#.###.###.##
.#.#.#.....#...
.#######.###.#.
.#.........#.#."""

#show(draw_maze(s))
a = solve_maze(s)
a.show(delay=20)
