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

def solve_maze(s, enter, exit):
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

import random
@interact
def generate_maze(N = slider([0..10], default=7)):
    D = (-2,0), (0,2), (2,0), (0,-2)
    Map = {(i,j):2-(i%2|j%2) for i in xrange(N) for j in xrange(N)}
    #Todo = [(N/2&-2,N/2&-2)] if random.randrange(2) else [(0,0),(N-1,N-1)]
    Todo = [(0,0),(N-1,N-1)]
    for x,y in Todo:
        Map[x,y]=0

    while Todo:
        x,y = Todo.pop(random.randrange(len(Todo)))
        Check = [(dx,dy) for dx,dy in D if 0<=x+dx<N and 0<=y+dy<N and Map[x+dx,y+dy]]
        if Check:
            dx,dy = random.choice(Check)
            Todo.extend([(x,y),(x+dx,y+dy)])
            Map[x+dx,y+dy]=Map[x+dx/2,y+dy/2]=0
    res = ""
    for i in xrange(N):
        res += "".join(".#"[Map[i,j]] for j in xrange(N)) + '\n'
    a = solve_maze(res, (0,0), (N,N))
    a.show(delay=20)
    return a

