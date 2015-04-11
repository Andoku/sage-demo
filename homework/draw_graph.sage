def draw_graph(graph, vertex_colors={}):
    return graph.graphplot(vertex_colors=vertex_colors)


def search_graph(g, first, last):
    res = list(g.breadth_first_search(first))
    a = []
    colors = {}
    colors["#8ca7c6"] = g.vertices()
    colors["#db4437"] = []
    colors["#10721e"] = []
    a.append(draw_graph(g, colors))
    for v in res:
        colors["#8ca7c6"].remove(v)
        if(v == last):
            colors["#10721e"].append(v)
            a.append(draw_graph(g, colors))
            return animate(a)
        colors["#db4437"].append(v)
        a.append(draw_graph(g, colors))
    return animate(a)

G = graphs.WheelGraph(15)
search_graph(G, 0, 7).show(delay=20)

