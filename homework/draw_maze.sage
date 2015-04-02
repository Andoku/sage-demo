def draw_maze(maze):
    h = len(maze)
    w = len(maze[0])
    g = Graphics()
    g += line([(0,0), (w,0), (w,h), (0,h), (0,0)])
    for y in xrange(0, h):
        for x in xrange(0, w):
            if maze[y][x] == '#':
                g += polygon([(x,h-y-1), (x+1,h-y-1), (x+1, h-y), (x,h-y)])
            elif maze[y][x] == '1':
		a = 1  
                g += polygon([(x,h-y-1), (x+1,h-y-1), (x+1, h-y), (x,h-y)], rgbcolor=(1,0,1))
    g.axes(False)
    return g

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

def solve_maze(s, enter, exit):
    l = s.splitlines()
    HEIGHT = len(l)
    WIDTH = len(l[0])
    ll = [list(st) for st in l]
    animation = []
    plan = [enter]
    while(len(plan) > 0):
        v = plan.pop()
        ll[v[0]][v[1]] = '1'
        animation.append(draw_maze(ll))
        for x in succ(v, HEIGHT):
            if l[x[0]][x[1]] == '#':
                continue
            if x == exit:
                print "YES"
                ll[x[0]][x[1]] = '1'
                animation.append(draw_maze(ll))
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

a = solve_maze(s, (0,0), (14, 14))
a.show(delay=20)
