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
    g.axes(False)
    return g

def animated_search(s, enter, exit):
    plan = [(enter, 1)] 
    while !plan.empty():
	node = plan.pop()
    


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

show(draw_maze(s))
